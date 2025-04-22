abstract class HasLabel {
  String get label;
}

enum GenderEnum implements HasLabel {
  male('Male'),
  female('Female');

  @override
  final String label;

  const GenderEnum(this.label);
}


enum DailyActivityEnum implements  HasLabel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extremelyActive;

  @override
  String get label {
    switch (this) {
      case DailyActivityEnum.sedentary:
        return 'Sédentaire';
      case DailyActivityEnum.lightlyActive:
        return 'Légèrement actif';
      case DailyActivityEnum.moderatelyActive:
        return 'Modérément actif';
      case DailyActivityEnum.veryActive:
        return 'Très actif';
      case DailyActivityEnum.extremelyActive:
        return 'Extrêmement actif';
    }
  }
}

enum GoalEnum implements  HasLabel {
  all,
  loseWeight,
  gainWeight,
  buildMuscle;

  @override
  String get label {
    switch (this) {
      case GoalEnum.all:
        return 'Tous';
      case GoalEnum.loseWeight:
        return 'Perdre du poids';
      case GoalEnum.gainWeight:
        return 'Prendre du poids';
      case GoalEnum.buildMuscle:
        return 'Se muscler';
    }
  }
}
