export 'app_model.dart';
export 'therapy_game.dart';

class DisabilityBenefit {
  final String title;
  final String category;
  final String description;
  final String actReference;
  final String learnMoreUrl;
  final String icon;

  const DisabilityBenefit({
    required this.title,
    required this.category,
    required this.description,
    required this.actReference,
    required this.learnMoreUrl,
    required this.icon,
  });
}

class CareerOption {
  final String title;
  final String description;
  final String icon;
  final String salaryRange;
  final List<String> skillTags;
  final bool isForChild;

  CareerOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.salaryRange,
    required this.skillTags,
    required this.isForChild,
  });
}