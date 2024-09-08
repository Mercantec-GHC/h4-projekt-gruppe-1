class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    @game = Match.find(params[:game_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def join(data)
    player_data = data["playerInfo"]
    @player_instance = UserStat.find_by(user_id: player_data["user_id"])
    @game.rounds = 1
    if player_data["player_type"] == "host"
      @game.player_1_user_name = player_data["user_name"]
    elsif player_data["player_type"] == "join"
      @game.player_2_user_name = player_data["user_name"]
    end
    @game.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
  end



  def leave(data)
    @game.player_2_user_name = " "
    @game.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_leave"})
  end

  def start(data)
    @game.timer = data["timer"].to_i
    @game.save
    @beat_boxer = BeatBoxer.all
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_start", beat_boxer: @beat_boxer})
  end

  def delete(data)
    @game.destroy
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_delete"})
  end

  def start_timer(data)
    @game = Match.find(params[:game_id])
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "timer_started"})
    Thread.new(count_down(data))
  end

  def count_down(data)
    timer = @game.timer
    while timer >= 0
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "count_down", timer: timer})
      timer -= 1
      sleep(1)
    end
    if @game.rounds == 6
      determine_winner()
    else
      @game = Match.find(params[:game_id])
      @game.rounds += 1
      @game.save
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "round_over", rounds: @game.rounds})
    end
  end

  def skip(data)
    @game = Match.find(params[:game_id])
    update_user_stats(data, "skip")
    point_giver(data, -1)
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
  end

  def point(data)
    @game = Match.find(params[:game_id])
    update_user_stats(data, "point")
    point_giver(data, 1)
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
  end



  def game_over(data)
    user = User.find(@player_instance.user_id)
    @game = Match.find(params[:game_id])
    if user.username == @game.winner
      @player_instance.wins += 1
    elsif user.username == @game.loser
      @player_instance.lost += 1
    else
      @player_instance.draw += 1
    end
    @player_instance.save
  end

  def comment(data)
    puts data
  end


    private

  def update_user_stats(data, type)
    if type == "skip"
      @player_instance.skips += 1
    elsif type == "point"
      @player_instance.right_guesses += 1
    end
    @player_instance.save
  end



  def point_giver(data, points)
    if data["host"] == "true"
      @game.rounds > 4 ? @game.player_1_points += points * 2 : @game.player_1_points += points
    else
      @game.rounds > 4 ? @game.player_2_points += points * 2 : @game.player_2_points += points

    end
    @game.save
  end

  def determine_winner()
    if @game.player_1_points > @game.player_2_points
      @game.winner = @game.player_1_user_name
      @game.loser = @game.player_2_user_name
    elsif @game.player_1_points < @game.player_2_points
      @game.winner = @game.player_2_user_name
      @game.loser = @game.player_1_user_name
    else
      @game.draw = true
    end

    @game.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_over"})
  end
end
