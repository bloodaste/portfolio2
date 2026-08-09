import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/resume_data.dart';
import '../theme.dart';
import 'shared_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: '// 01 — Work Experience',
            title: "Where I've Worked",
          ),
          const SizedBox(height: 28),
          ...ResumeData.experience.map((exp) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _ExpCard(exp: exp),
              )),
        ],
      ),
    );
  }
}

class _ExpCard extends StatefulWidget {
  final Experience exp;
  const _ExpCard({required this.exp});

  @override
  State<_ExpCard> createState() => _ExpCardState();
}

class _ExpCardState extends State<_ExpCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.exp.company,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.exp.date,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.exp.role,
              style: const TextStyle(
                color: AppColors.accent2,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            ...widget.exp.bullets.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(color: AppColors.muted, fontSize: 13)),
                      Expanded(
                        child: Text(
                          b,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
