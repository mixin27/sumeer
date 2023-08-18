enum SkillLevelEnum {
  novice('Novice'),
  beginner('Beginner'),
  skillfull('Skillfull'),
  experienced('Experienced'),
  expert('Expert');

  const SkillLevelEnum(this.type);

  final String type;
}

enum LanguageLevelEnum {
  beginner('Beginner'),
  elementary('Elementary'),
  limitedWorking('LimitedWorking'),
  highlyProficient('HighlyProficient'),
  native('Native');

  const LanguageLevelEnum(this.type);

  final String type;
}

extension ConvertEnum on String {
  SkillLevelEnum toSkillLevelEnum() {
    switch (this) {
      case 'Novice':
        return SkillLevelEnum.novice;
      case 'Beginner':
        return SkillLevelEnum.beginner;
      case 'Skillfull':
        return SkillLevelEnum.skillfull;
      case 'Experienced':
        return SkillLevelEnum.experienced;
      case 'Expert':
        return SkillLevelEnum.expert;
      default:
        return SkillLevelEnum.beginner;
    }
  }

  LanguageLevelEnum toLangLevelEnum() {
    switch (this) {
      case 'Beginner':
        return LanguageLevelEnum.beginner;
      case 'Elementary':
        return LanguageLevelEnum.elementary;
      case 'LimitedWorking':
        return LanguageLevelEnum.limitedWorking;
      case 'HighlyProficient':
        return LanguageLevelEnum.highlyProficient;
      case 'Native':
        return LanguageLevelEnum.native;
      default:
        return LanguageLevelEnum.beginner;
    }
  }
}
