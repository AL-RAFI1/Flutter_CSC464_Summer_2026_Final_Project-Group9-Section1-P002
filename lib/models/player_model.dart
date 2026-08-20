class PlayerModel {
  final String id;
  final String name;
  final String symbol; // 'X' or 'O'
  final int wins;
  final int losses;
  final int ties;

  PlayerModel({
    required this.id,
    required this.name,
    required this.symbol,
    this.wins = 0,
    this.losses = 0,
    this.ties = 0,
  });

  int get totalGames => wins + losses + ties;

  PlayerModel copyWith({
    String? id,
    String? name,
    String? symbol,
    int? wins,
    int? losses,
    int? ties,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      ties: ties ?? this.ties,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'wins': wins,
      'losses': losses,
      'ties': ties,
    };
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Player',
      symbol: json['symbol'] as String? ?? 'X',
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      ties: (json['ties'] as num?)?.toInt() ?? 0,
    );
  }
}
