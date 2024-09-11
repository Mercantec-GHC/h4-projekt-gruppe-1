class CountdownJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Match.find(game_id)
    timer = game.timer

    while timer >= 0
      if timer == game.timer / 2
        ActionCable.server.broadcast("game_channel_#{game_id}", { type: "half_time" })
      end
      ActionCable.server.broadcast("game_channel_#{game_id}", { type: "count_down", timer: timer })
      timer -= 1
      sleep(1)
    end

    if game.rounds == 6
    else
      game.rounds += 1
      game.save
      ActionCable.server.broadcast("game_channel_#{game_id}", { type: "round_over", rounds: game.rounds })
    end
  end
end
