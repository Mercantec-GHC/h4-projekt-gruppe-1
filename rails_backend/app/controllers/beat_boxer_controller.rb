class BeatBoxerController < ApplicationController
  # before_action :jwt_test

  def show
    
  end

  def create

    
  end

  def destroy
  end

  def index
    beat_boxers = BeatBoxer.all
    render json: beat_boxers, except: [:id, :created_at, :updated_at], status: :ok
  end




  private

  def jwt_test
    token = request.headers["autherization"]
    if token
      puts token
      begin
        decoded_token = JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: "HS256"})
        # puts decoded_token[0]["sub"]
        @test_user = TestUser.new(decoded_token[0]["sub"], "12345678")
        puts @test_user.name
      rescue JWT::DecodeError
        render json: {error: "Invalid token"}, status: :unauthorized
      end
    else
      render json: {error: "No token"}, status: :unauthorized
    end
  end

  def beat_boxer_names 
    beatboxers = [
      "Ariel Pink",
      "Biz Markie",
      "Butterscotch",
      "Chris Celiz",
      "Buffy",
      "Doug E. Fresh",
      "D-Nice",
      "Gene Shinozaki",
      "Jeff Thacher",
      "Kaila Mullady",
      "Kevin Olusola",
      "Kid Lucky",
      "King Inertia",
      "KRNFX",
      "Mark Martin",
      "Matisyahu",
      "Michael Winslow",
      "Mike Tompkins",
      "Rahul",
      "Rahzel",
      "Ready Rock C",
      "Reggie Watts",
      "Stagename",
      "SungBeats",
      "Timbaland",
      "Villain",
      "Wise",
      "Wes Carroll",
      "André Pinguim",
      "Gonza",
      "Beardyman",
      "Reeps One",
      "SkilleR",
      "Killa Kela",
      "Alem",
      "Ayoub",
      "Beardyman",
      "Chlorophil",
      "Danubio",
      "Deity",
      "D-Low",
      "G-Wizz",
      "Hampi",
      "Jay Sean",
      "Juls",
      "Killa Kela",
      "Lukash",
      "Matej",
      "MB14",
      "Reeps One",
      "RoxorLoops",
      "Shlomo",
      "SkilleR",
      "Timmeh",
      "Virgin Islands",
      "Voxel",
      "Zampa",
      "Zeero",
      "Afra",
      "Artsy",
      "Bigman",
      "Dilip",
      "H-Has",
      "Hikakin",
      "Hiss",
      "Hookha",
      "Jack Beats",
      "Mr.T",
      "SO-SO",
      "Thai Son",
      "Vineeth Vincent",
      "Wing",
      "Yuichi Nakamaru",
      "Yuske",
      "Zhang Ze",
      "Joel Turner",
      "Codfish",
      "Dub FX",
      "Joel Turner",
      "Tom Thum",
      "Damkina",
      "George Avakian",
      "Thierry Olemba",
      "ZigZap"
    ]
  end



end





