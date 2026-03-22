class TherapyGame {
  final String title;
  final String icon;
  final String category;
  final String duration;
  final String objective;
  final String materials;
  final String howToPlay;
  final String benefit;
  final List<String> ageGroups;
  final List<String> supportLevels;

  TherapyGame({
    required this.title,
    required this.icon,
    required this.category,
    required this.duration,
    required this.objective,
    required this.materials,
    required this.howToPlay,
    required this.benefit,
    required this.ageGroups,
    required this.supportLevels,
  });
}