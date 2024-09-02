class MatchHistory {
  String winner;
  String loser;
  int player_1_points;
  int player_2_points;
  bool draw;
  String player_1_comment;
  String player_2_comment;
  String player_1_user_name;
  String player_2_user_name;
  DateTime createdAt;

  MatchHistory({
    this.winner = "",
    this.loser = "",
    this.player_1_points = 0,
    this.player_2_points = 0,
    this.draw = false,
    this.player_1_comment = "",
    this.player_2_comment = "",
    this.player_1_user_name = "",
    this.player_2_user_name = "",
    required this.createdAt
  });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
      winner: json['winner'],
      loser: json['loser'],
      player_1_points: json['player_1_points'],
      player_2_points: json['player_2_points'],
      draw: json['draw'],
      player_1_comment: json['player_1_comment'],
      player_2_comment: json['player_2_comment'],
      player_1_user_name: json['player_1_user_name'],
      player_2_user_name: json['player_2_user_name'],
      createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now(),
    );
  }
}