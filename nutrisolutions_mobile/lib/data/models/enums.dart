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

enum DailyActivityEnum implements HasLabel {
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

enum GoalEnum implements HasLabel {
  all,
  loseWeight,
  gainWeight,
  buildMuscle,
  maintainWeight;

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
      case GoalEnum.maintainWeight:
        return 'Maintenir le poids';
    }
  }
}

enum CategoryEnum implements HasLabel {
  all('Tous'),
  diner('Diner'),
  dej('Déjeuner'),
  petitDej('Petit Déjeuner'),
  snack('Snack'),
  entree('Entrée'),
  principal('Plat principal');

  @override
  final String label;

  const CategoryEnum(this.label);
}

enum PreparationTimeEnum implements HasLabel {
  all('Tous'),
  veryShort('Moins de 15 minutes'),
  short('15-30 minutes'),
  medium('30-45 minutes'),
  long('45-60 minutes'),
  veryLong('Plus de 60 minutes');

  @override
  final String label;

  const PreparationTimeEnum(this.label);
}

enum ExperienceEnum implements HasLabel {
  all('Tous'),
  junior('1-3 ans'),
  midLevel('4-6 ans'),
  senior('7-10 ans'),
  seniorPlus('Plus de 10 ans');

  @override
  final String label;

  const ExperienceEnum(this.label);
}
