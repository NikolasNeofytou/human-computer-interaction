enum ProjectStatus { onTrack, dueSoon, blocked }

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.status,
    required this.tasks,
  });

  final String id;
  final String name;
  final ProjectStatus status;
  final int tasks;
}
