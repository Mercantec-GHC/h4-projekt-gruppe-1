require "rails_helper"



RSpec.describe "UserStats", type: :request do
    before(:all) do
        @token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtpbUBray5jb20iLCJleHAiOjE3MjYwNzc2MzEsImlhdCI6MTcyNjA3NzU3MSwiaWQiOjIwLCJpc3MiOiJ0b2tlbi1hdXRoIiwicGhvbmUiOiIxMjM0NTY3OCIsInN1YiI6IktpbSIsInVzZXJuYW1lIjoiS3JpeHp5In0.TJO8gygw62CvJD9gtomUG3642cNExtuyzhT1dO17H0o"
      end
    describe "GET /user_stat" do
      it "returns a list of user_stats" do
        UserStat.create(wins: 15, lost: 5, games_played: 20, right_guesses: 15, skips: 5)
        UserStat.create(wins: 10, lost: 10, games_played: 10, right_guesses: 10, skips: 10)
        get '/user_stat', headers: {"Authorization" => "Bearer #{@token}"}
        puts request.headers['Authorization']
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to be >= 2
      end
      it "returns unauthorized without token" do
        get '/user_stat'
        expect(response).to have_http_status(:unauthorized)
      end
        
    end
    describe "GET /user_stat/:id" do
        it "returns a user_stat" do
            user_stat = UserStat.create(wins: 1, lost: 1, games_played: 1, right_guesses: 1, skips: 1)
            get "/user_stat/#{user_stat.id}", headers: {"Authorization" => "Bearer #{@token}"}
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).to include("wins" => 1, "lost" => 1, "games_played" => 1, "right_guesses" => 1, "skips" => 1)
            expect(JSON.parse(response.body)).to include("id" => user_stat.id)
        end
        it "returns not found" do
            get "/user_stat/1", headers: {"Authorization" => "Bearer #{@token}"}
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "POST /user_stat" do
        it "creates a user_stat" do
            post "/user_stat", headers: {"Authorization" => "Bearer #{@token}"}
            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)).to include("wins" => 0, "lost" => 0, "games_played" => 0, "right_guesses" => 0, "skips" => 0)
        end
        it "returns unauthorized without token" do
            post "/user_stat"
            expect(response).to have_http_status(:unauthorized)
        end
    end

    describe "PUT /user_stat/:id" do
        # it "updates a user_stat" do
        #     user_stat = UserStat.create(wins: 1, lost: 1, games_played: 1, right_guesses: 1, skips: 1)
            
        #     put "/user_stat/#{user_stat.id}", 
        #         params: { wins: 2, lost: 2, games_played: 2, right_guesses: 2, skips: 2 },
        #         headers: { 
        #           "Authorization" => "Bearer #{@token}",
        #           "Content-Type" => "application/json" 
        #         }
            
        #     expect(response).to have_http_status(:ok)
        #     expect(JSON.parse(response.body)).to include("wins" => 2, "lost" => 2, "games_played" => 2, "right_guesses" => 2, "skips" => 2)
        #   end
        it "returns not found" do
            put "/user_stat/1", headers: {"Authorization" => "Bearer #{@token}", params: {wins: 2, lost: 2, games_played: 2, right_guesses: 2, skips: 2}}
            expect(response).to have_http_status(:not_found)
        end
        it "returns unauthorized without token" do
            put "/user_stat/1", params: {wins: 2, lost: 2, games_played: 2, right_guesses: 2, skips: 2}
            expect(response).to have_http_status(:unauthorized)
        end
    end
  end