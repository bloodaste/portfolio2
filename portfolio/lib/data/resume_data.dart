import '../models/project.dart';

class Experience {
  final String company;
  final String role;
  final String date;
  final List<String> bullets;

  const Experience({
    required this.company,
    required this.role,
    required this.date,
    required this.bullets,
  });
}

class SkillGroup {
  final String name;
  final List<String> skills;
  const SkillGroup({required this.name, required this.skills});
}

class ResumeData {
  static const List<Experience> experience = [
    Experience(
      company: 'SMITS, Inc. — San Miguel Corporation',
      role: 'IT Application Specialist | L1/L2 Application Support',
      date: 'Sep 2025 – Present',
      bullets: [
        'Provide support and guidance to users experiencing system-related issues, ensuring quick resolution and positive UX.',
        'Respond to support tickets submitted via email, chat, and internal tools (ServiceNow).',
        'Collaborate with developers, business analysts, and end users to maintain smooth system operations.',
        'Gather and prepare user-provided data for developers, enabling more accurate and efficient problem-solving.',
        'Escalate complex issues to development or infrastructure teams when necessary.',
      ],
    ),
    Experience(
      company: 'Freelance Flutter Developer',
      role: 'Self-Employed',
      date: 'Oct 2025 – Present',
      bullets: [
        'Develop and implement cross-platform applications for seamless web and mobile access.',
        'Maintain robust data protection measures to ensure user privacy and security.',
        'Maintain and optimize applications to ensure smooth performance for business processes.',
      ],
    ),
    Experience(
      company: 'Intelliseven Technology Solutions Inc.',
      role: 'Back-end Developer',
      date: 'Jun 2024 – Aug 2024',
      bullets: [
        'Designed and implemented developer-friendly APIs for seamless frontend integration.',
        'Built scalable, high-performance databases to support growing user demand.',
        'Worked cross-functionally with frontend developers to optimize usability and performance.',
      ],
    ),
  ];

  static const List<Project> defaultProjects = [
    Project(
      name: 'Excel Splitter',
      tech: 'GoLang · Excel Automation',
      desc:
          'A GoLang program that automatically splits large Excel files by a specific column into separate files, with dynamic sanitized filenames and date-stamping for organization.',
    ),
    Project(
      name: 'Father Migs Box Break Platform',
      tech: 'Flutter · Firebase · Realtime DB',
      desc:
          'Mobile application that enables clients to view inventory anytime via Firebase Realtime Database. Includes XLSX export for reporting and analytical purposes.',
    ),
    Project(
      name: 'AIMS — Automated Inventory Management System',
      tech: 'Flutter · Barcode Scanner · Sensors',
      desc:
          'Thesis project: high-performance cross-platform inventory management app using Flutter. Integrated external barcode scanners and sensors to automate inventory input and reduce manual errors.',
    ),
    Project(
      name: 'Patintero',
      tech: 'Flutter · Firebase · Riverpod',
      desc:
          'A dating/game hybrid app currently in active development. Implements Firebase Cloud Messaging (FCM) for real-time notifications and a clean Riverpod state management architecture.',
      status: 'In Development',
    ),
  ];

  static const List<SkillGroup> skills = [
    SkillGroup(name: 'Languages', skills: ['Dart', 'JavaScript', 'GoLang', 'HTML', 'CSS']),
    SkillGroup(name: 'Framework', skills: ['Flutter', 'Riverpod']),
    SkillGroup(name: 'Backend & DB', skills: ['Firebase', 'MongoDB', 'SQL']),
    SkillGroup(name: 'Tools', skills: ['ServiceNow', 'MS Office', 'Prompt Eng.']),
  ];
}
