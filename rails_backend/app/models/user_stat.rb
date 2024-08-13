class UserStat < ApplicationRecord
    validates :wins, :lost, :games_played, :right_guesses, :skips, presence: true
    has_one :user
end
