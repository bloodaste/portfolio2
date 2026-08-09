import 'package:flutter/material.dart';
import '../data/resume_data.dart';
import '../theme.dart';
import 'shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '// 03 — Skills',
            title: 'Tools & Technologies',
          ),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;
            if (isWide) {
              final rows = <Widget>[];
              final groups = ResumeData.skills;
              for (var i = 0; i < groups.length; i += 2) {
                rows.add(Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _SkillGroupCard(group: groups[i])),
                    const SizedBox(width: 12),
                    if (i + 1 < groups.length)
                      Expanded(child: _SkillGroupCard(group: groups[i + 1]))
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ));
                if (i + 2 < groups.length) rows.add(const SizedBox(height: 12));
              }
              return Column(children: rows);
            } else {
              return Column(
                children: ResumeData.skills
                    .map((g) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _SkillGroupCard(group: g),
                        ))
                    .toList(),
              );
            }
          }),
        ],
      ),
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  final SkillGroup group;
  const _SkillGroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.name.toUpperCase(),
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: group.skills.map((s) => SkillTag(s)).toList(),
          ),
        ],
      ),
    );
  }
}
