class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    @instance = Match.find(params[:game_id])
  end

  def unsubscribed
  end




  def join(data)
    player_data = data["playerInfo"]


    if player_data["player_type"] == "host"
      @instance.player_1_user_name = player_data["user_name"]
    elsif player_data["player_type"] == "join"
      @instance.player_2_user_name = player_data["user_name"]
    end
    @instance.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @instance})
    
  end

  def leave(data)
    @instance.player_2_user_name = " "
    @instance.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @instance})
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_leave"})
  end

  def start(data)
    @instance.timer = data["timer"].to_i
    @instance.rounds = 1
    @instance.save
    @beat_boxer = BeatBoxer.all
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_start", beat_boxer: @beat_boxer})
  end

  def delete(data)
    @instance.destroy
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_delete"})
  end

  def start_timer(data)
    @instance = Match.find(params[:game_id])
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "timer_started"})
    Thread.new(count_down(data))
  end

  def count_down(data)
    timer = @instance.timer
    while timer >= 0
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "count_down", timer: timer})
      timer -= 1
      sleep(1)
    end
    if @instance.rounds == 6
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_over", timer: timer})
    else
      @instance.rounds += 1
      @instance.save
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "round_over", timer: timer})
    end
  end

  def skip(data)
    @instance = Match.find(params[:game_id])
    if data["host"] == true
      @instance.player_1_score -= 1
    else
      @instance.player_2_score -= 1
    end
    @instance.save
    if 
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @instance})

    
  end

  def point(data)


end
