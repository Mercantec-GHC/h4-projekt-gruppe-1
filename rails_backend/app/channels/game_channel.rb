class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    @instance = Match.find(params[:game_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", data)
  end

  def receive(data)
    # Print the parsed game data as a JSON string
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game", game: [test: "test"]})
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

  # def start(data)
  #   @instance.start_game
  #   ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_update", game: @instance})
  # end

  def delete(data)
    @instance.destroy
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game_delete"})
  end
end
