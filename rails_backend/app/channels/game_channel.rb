class GameChannel < ApplicationCable::Channel
  # This channel is used to handle the game logic


  # this is used to subscribe to the channel and fetch the game instance
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    @game = Match.find(params[:game_id])
  end

  # this handel if you unsubscribe from the channel while in a game
  def unsubscribed
    if Match.exists?(params[:game_id])
      @game = Match.find(params[:game_id])
      if @game.rounds < 6 && @game.rounds > 0
        determine_winner(true)
        @game.rounds = 6
        @game.save

      end
    end  
  end


  # this handels if a player joins the game
  def join(data)
    player_data = data["playerInfo"]
    @player_instance = UserStat.find_by(user_id: player_data["user_id"])
    @game.user_ids = @game.user_ids + [@player_instance["user_id"]] unless @game.user_ids.include?(@player_instance["user_id"])
    if player_data["player_type"] == "host"
      @game.player_1_user_name = player_data["user_name"]
    elsif player_data["player_type"] == "join"
      @game.player_2_user_name = player_data["user_name"]
    end
    @game.save
    update_players()
  end


  # this handels if a player leaves the game
  def leave(data)
    @game.player_2_user_name = " "
    @game.user_ids = @game.user_ids - [@player_instance.user_id]
    @game.save
    update_players()
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_leave"})
  end

  # this handels if a player starts the game
  def start(data)
    @game = Match.find(params[:game_id])
    @game.timer = data["timer"].to_i
    @game.rounds = 1
    @game.save
    @beat_boxer = BeatBoxer.all
    update_players()
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_start", beat_boxer: @beat_boxer})
  end

  # this handels if a player deletes the game this can only happen if the host leaves the lobby
  def delete(data)
    @game.destroy
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_delete"})
  end

  # this handels when the player starts the timer
  def start_timer(data)
    @game = Match.find(params[:game_id])
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "timer_started"})
    Thread.new do
      count_down(data)
    end
    
  end
  # this never got finished but it was a better way to run the timer
  # def start_timer(data)
  #   @game = Match.find(params[:game_id])
  #   ActionCable.server.broadcast("game_channel_#{params[:game_id]}", { type: "timer_started" })
  #   CountdownJob.perform_later(@game.id)
  # end
   
  # this count down the timer and handels the end of the round
  def count_down(data)
    timer = @game.timer
    while timer >= 0
      if timer == @game.timer / 2
        ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "half_time"})
      end
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "count_down", timer: timer})
      timer -= 1
      sleep(1)
    end
    if @game.rounds == 6
      @game = Match.find(params[:game_id])
      determine_winner()
    else
      @game = Match.find(params[:game_id])
      @game.rounds += 1
      @game.save
      ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "round_over", rounds: @game.rounds})
    end
  end

  # this handels if a player skips a beatboxer
  def skip(data)
    @game = Match.find(params[:game_id])
    update_user_stats(data, "skip")
    update_player_points(data, -1)
    update_players()
  end

  # this handels if a player guesses the beatboxer
  def point(data)
    @game = Match.find(params[:game_id])
    update_user_stats(data, "point")
    update_player_points(data, 1)
    update_players()
  end

  # this handels when the game is over and the player leaves a comment
  def comment(data)
    @game = Match.find(params[:game_id])
    if data["host"]
      @game.player_1_comment = data["comment"]
    else
      @game.player_2_comment = data["comment"]
    end
    @game.save

  end

  # this handels when the player updates the timer
  def update_timer(data)
    @game.timer = data["timer"]
    @game.save
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "timer_update", timer: @game.timer})
  end

    private
  # this updates the user stats if there player skips or guesses the beatboxer and update database
  def update_user_stats(data, type)
    if type == "skip"
      @player_instance.skips += 1
    elsif type == "point"
      @player_instance.right_guesses += 1
    end
    @player_instance.save
  end


  # this updates the player points
  def update_player_points(data, points)
    if data["host"] == "true"
      @game.rounds > 4 ? @game.player_1_points += points * 2 : @game.player_1_points += points
    else
      @game.rounds > 4 ? @game.player_2_points += points * 2 : @game.player_2_points += points

    end
    @game.save
  end

  # this determines the winner of the game
  def determine_winner(leaver = false)
      @game = Match.find(params[:game_id])
      puts @game.inspect 
    if leaver
      assign_winner(@game.user_ids.select { |id| id != @player_instance.user_id }[0], @player_instance.user_id)
    else
      if @game.player_1_points > @game.player_2_points
        assign_winner(User.find_by(username: @game.player_1_user_name).id, User.find_by(username: @game.player_2_user_name).id)
      elsif @game.player_1_points < @game.player_2_points
        assign_winner(User.find_by(username: @game.player_2_user_name).id, User.find_by(username: @game.player_1_user_name).id)
      else
        @game.draw = true
      end
    end 
    @game.save
    game_over()
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_over", game: @game})
  end


  # this is just a function to update the players to the game channel
  def update_players
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @game})
  end

  # this handels the game over logic
  def game_over()
    @game = Match.find(params[:game_id])
    @game.user_ids.each do |id|
      player_instance = UserStat.find_by(user_id: id)
      if player_instance.user_id == @game.winner.to_i
        player_instance.wins += 1
      elsif player_instance.user_id == @game.loser.to_i
        player_instance.lost += 1
      else
        player_instance.draw += 1
      end
      player_instance.games_played += 1
      player_instance.save 
    end
  end

  # this assigns the winner and loser of the game
  def assign_winner(winner, loser)
    @game.winner = winner
    @game.loser = loser
  end
  

end
