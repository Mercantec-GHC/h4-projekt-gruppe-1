
class UserStats {
    int wins; 
    int lost;
    int gamesPlayed; 
    int rightGuesses;
    int skips;
    String updated;
    
    UserStats({this.wins = 0, this.lost = 0, this.gamesPlayed = 0, this.rightGuesses = 0, this.skips = 0, this.updated = " "});


    factory UserStats.fromJson(Map<String, dynamic> json) {
      return UserStats(
        wins: json['wins'],
        lost: json['lost'],
        gamesPlayed: json['games_played'],
        rightGuesses: json['right_guesses'],
        skips: json['skips'],
        updated: json['updated_at'],
      );
    }
}