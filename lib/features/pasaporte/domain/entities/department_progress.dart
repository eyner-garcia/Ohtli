class DepartmentProgress {
  final String id;
  final bool completed;
  final bool completedNow;
  final int currentPercentage;
  final int previousPercentage;

  const DepartmentProgress({
    required this.id,
    required this.completed,
    required this.completedNow,
    required this.currentPercentage,
    required this.previousPercentage,
  });
}