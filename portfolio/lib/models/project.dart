class Project {
  final String name;
  final String tech;
  final String desc;
  final String? github;
  final String? live;
  final String? status;
  final bool isUserAdded;

  const Project({
    required this.name,
    required this.tech,
    required this.desc,
    this.github,
    this.live,
    this.status,
    this.isUserAdded = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'tech': tech,
        'desc': desc,
        'github': github,
        'live': live,
        'status': status,
        'isUserAdded': isUserAdded,
      };

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        name: json['name'] ?? '',
        tech: json['tech'] ?? '',
        desc: json['desc'] ?? '',
        github: json['github'],
        live: json['live'],
        status: json['status'],
        isUserAdded: json['isUserAdded'] ?? true,
      );
}
