class GameChannel < ApplicationCable::Channel
  def subscribed
    @instance = Game.find(params[:game_id])
    stream_from "game_channel_#{params[:game_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", data)
  end

  def receive(data)
    ActionCable.server.broadcast("game_channel_#{params[:game_id]}", {type: "game", game: [test: "test"]})
  end 
end
