class Score {
  int score;
  Duration duration;

  Score({
    required this.score,
    required this.duration,
  });

  
  int get getScore => score;
  Duration get getDuration => duration;

  set setScore(int score) => this.score = score;
  set setDuration(Duration duration) => this.duration = duration;
}
