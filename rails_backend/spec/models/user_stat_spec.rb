require "rails_helper"

RSpec.describe UserStat, type: :model do
    it "is valid with valid attributes" do
        user_stat = UserStat.new(wins: 0, lost: 0, games_played: 0, right_guesses: 0, skips: 0)
        expect(user_stat).to be_valid
    end
    it "is not valid without a wins" do
        user_stat = UserStat.new(wins: nil, lost: 0, games_played: 0, right_guesses: 0, skips: 0)
        expect(user_stat).to_not be_valid
    end
end
