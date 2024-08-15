class UserStat < ApplicationRecord
    validates :wins, :lost, :games_played, :right_guesses, :skips, presence: true
    validates :wins, :lost, :games_played, :right_guesses, :skips, numericality: { only_integer: true }
end
