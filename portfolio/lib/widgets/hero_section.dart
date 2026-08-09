import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 72, 24, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// IT Application Specialist & Flutter Developer',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              color: AppColors.accent,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Kurt Andrei\n',
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 52,
                    color: AppColors.textColor,
                    height: 1.05,
                  ),
                ),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.accent, AppColors.accent2],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'Gutierrez',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 52,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Building cross-platform apps with Flutter & Firebase.\nIT Application Specialist at SMITS, Inc. — San Miguel Corporation.\nBased in Bulacan, Philippines.',
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _PrimaryBtn(
                label: '✉  kurtandrei50@gmail.com',
                onTap: () => _launch('mailto:kurtandrei50@gmail.com'),
              ),
              _GhostBtn(
                label: '↗  LinkedIn',
                onTap: () => _launch(
                    'https://linkedin.com/in/kurt-andrei-a-gutierrez-8a763623a/'),
              ),
              _GhostBtn(
                label: '↗  GitHub',
                onTap: () => _launch('https://github.com/bloodaste'),
              ),
              _GhostBtn(
                label: '📞  +63 931 723 5372',
                onTap: () => _launch('tel:+639317235372'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
