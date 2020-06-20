class Score {
  int score1 = 0, score2 = 0;
  String serve1 = "*", serve2 = "", victory = "", rounds = "";
  bool end = false;
  int serve = 1, count = 0;
  int gameNum = 1, won1 = 0, won2 = 0;
  bool s_end = false;
  //bool justwon = false;

  void hardReset() {
    //gameNum = 0;
    won1 = 0;
    won2 = 0;
    victory = "";
    rounds = "";
    gameNum = 1;
    s_end = false;
    reset();
  }

  void s1() {
    if ((score1 >= 10 && (score1 - 1) >= score2) && end == false) {
      end = true;
      score1++;
      rounds += ' $score1-$score2 ';
      victory = "TanManPro Wins Game: $gameNum";
      won1 += 1;
      gameNum += 1;
      if (won1 == 3 || won2 == 3) {
        s_end = true;
        victory = "TanManPRO Wins the Series";
      }
      reset();
      return;
    }
    if (end == false) {
      victory = "";
    } // Resetting victory
    if (end == false && (score1 >= 10 && score2 >= 10)) {
      score1++;
      cs();
      return;
    }
    if (end == false) {
      score1++;
      count++;
      if (count % 2 == 0) {
        cs();
      }
    }
  }

  void s2() {
    if ((score2 >= 10 && (score2 - 1) >= score1) && end == false) {
      end = true;
      score2++;
      rounds += ' $score1-$score2 ';
      victory = "DineshBE Wins Game: $gameNum";
      won2 += 1;
      gameNum += 1;
      if (won1 == 3 || won2 == 3) {
        s_end = true;
        victory = "DineshBE Wins the Series";
      }
      reset();
      return;
    }
    if (end == false) {
      victory = "";
    }
    if (end == false && (score1 >= 10 && score2 >= 10)) {
      score2++;
      cs();
      return;
    }
    if (end == false) {
      score2++;
      count++;
      if (count % 2 == 0) {
        cs();
      }
    }
  }

  void reset() {
    if (gameNum % 2 == 1) {
      score1 = 0;
      score2 = 0;
      serve1 = "*";
      serve2 = "";
      serve = 1;
      end = false;
      count = 0;
    } else {
      score1 = 0;
      score2 = 0;
      serve1 = "";
      serve2 = "*";
      serve = 2;
      end = false;
      count = 0;
    }
  }

  void cs() {
    if (serve == 1) {
      serve1 = "";
      serve2 = "*";
      serve = 2;
      return;
    }
    if (serve == 2) {
      serve1 = "*";
      serve2 = "";
      serve = 1;
      return;
    }
  }

  String get_game() {
    return '$gameNum';
  }

  String get_vic() {
    return '$victory';
  }

  String get_score1() {
    return '$score1\n$serve1';
  }

  String get_score2() {
    return '$score2\n$serve2';
  }

  String get_won1() {
    return '$won1';
  }

  String get_won2() {
    return '$won2';
  }

  String get_rounds() {
    return '$rounds';
  }
}
