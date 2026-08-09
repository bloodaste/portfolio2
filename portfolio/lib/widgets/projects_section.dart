import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../theme.dart';
import 'shared_widgets.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;
  final void Function(int index)? onDelete;

  const ProjectsSection({
    super.key,
    required this.projects,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '// 02 — Projects',
            title: "Things I've Built",
          ),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            if (isWide) {
              // Two-column grid
              final rows = <Widget>[];
              for (var i = 0; i < projects.length; i += 2) {
                rows.add(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _ProjectCard(
                          project: projects[i],
                          onDelete: projects[i].isUserAdded && onDelete != null
                              ? () => onDelete!(i)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (i + 1 < projects.length)
                        Expanded(
                          child: _ProjectCard(
                            project: projects[i + 1],
                            onDelete: projects[i + 1].isUserAdded && onDelete != null
                                ? () => onDelete!(i + 1)
                                : null,
                          ),
                        )
                      else
                        const Expanded(child: SizedBox()),
                    ],
                  ),
                );
                if (i + 2 < projects.length) rows.add(const SizedBox(height: 16));
              }
              return Column(children: rows);
            } else {
              // Single column
              return Column(
                children: projects.asMap().entries.map((e) {
                  final idx = e.key;
                  final proj = e.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ProjectCard(
                      project: proj,
                      onDelete: proj.isUserAdded && onDelete != null
                          ? () => onDelete!(idx)
                          : null,
                    ),
                  );
                }).toList(),
              );
            }
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback? onDelete;
  const _ProjectCard({required this.project, this.onDelete});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top gradient bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                decoration: BoxDecoration(
                  gradient: p.isUserAdded
                      ? AppColors.gradientAccent2
                      : AppColors.gradientAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delete button for user-added projects
                    if (widget.onDelete != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: widget.onDelete,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                      ),
                    if (p.status != null) ...[
                      StatusBadge(p.status!),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      p.name,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.tech,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.accent,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      p.desc,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    if (p.github != null || p.live != null) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (p.github != null)
                            _LinkChip(
                              label: '↗  GitHub',
                              onTap: () => _launch(p.github!),
                            ),
                          if (p.live != null)
                            _LinkChip(
                              label: '↗  Live',
                              onTap: () => _launch(p.live!),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LinkChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}
