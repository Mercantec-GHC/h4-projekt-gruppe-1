class BeatBoxerController < LoginController

  #This controller is used to alle endpoints related to beatboxers



  # This is only used for populating the database
  def create
    beat_boxers = beat_boxer_names
    beat_boxers.each do |beat_boxer|
      BeatBoxer.create(name: beat_boxer)
    end
    render json: {message: "Beat Boxers created"}, status: :ok
    
  end

  # Fetches all beatboxers from the database GET /beat_boxers
  def index
    beat_boxers = BeatBoxer.all
    create() if beat_boxers.length == 0
    render json: beat_boxers, except: [:id, :created_at, :updated_at], status: :ok
  end




  private

  #List of beatboxers to be added to the database
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





