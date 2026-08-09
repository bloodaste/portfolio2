import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/resume_data.dart';
import '../models/project.dart';
import '../theme.dart';

import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/skills_section.dart';

const _prefsKey = 'kurt_portfolio_projects';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _scrollController = ScrollController();

  // Section keys for nav scrolling
  final _heroKey = GlobalKey();
  final _expKey = GlobalKey();
  final _projKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _eduKey = GlobalKey();
  final _addKey = GlobalKey();

  List<Project> _userProjects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      final list = (jsonDecode(raw) as List)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList();
      setState(() => _userProjects = list);
    }
  }

  Future<void> _saveProjects() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode(_userProjects.map((p) => p.toJson()).toList()),
    );
  }

  void _addProject(Project project) {
    setState(() => _userProjects.add(project));
    _saveProjects();
    // Scroll back to projects section
    _scrollToKey(_projKey);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✓ Project added!'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _deleteProject(int index) {
    // index is into the combined list; offset by defaultProjects length
    final userIndex = index - ResumeData.defaultProjects.length;
    if (userIndex < 0 || userIndex >= _userProjects.length) return;
    setState(() => _userProjects.removeAt(userIndex));
    _saveProjects();
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  List<Project> get _allProjects => [
        ...ResumeData.defaultProjects,
        ..._userProjects,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // Sticky nav
          _NavBar(
            onTapExperience: () => _scrollToKey(_expKey),
            onTapProjects: () => _scrollToKey(_projKey),
            onTapSkills: () => _scrollToKey(_skillsKey),
            onTapEducation: () => _scrollToKey(_eduKey),
            onTapAdd: () => _scrollToKey(_addKey),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    HeroSection(key: _heroKey),
                    const AppDivider(),
                    ExperienceSection(key: _expKey),
                    const AppDivider(),
                    ProjectsSection(
                      key: _projKey,
                      projects: _allProjects,
                      onDelete: _deleteProject,
                    ),
                    const AppDivider(),
                    SkillsSection(key: _skillsKey),
                    const AppDivider(),
                    EducationSection(key: _eduKey),
                    const AppDivider(),
                    _Footer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _NavBar extends StatelessWidget {
  final VoidCallback onTapExperience;
  final VoidCallback onTapProjects;
  final VoidCallback onTapSkills;
  final VoidCallback onTapEducation;
  final VoidCallback onTapAdd;

  const _NavBar({
    required this.onTapExperience,
    required this.onTapProjects,
    required this.onTapSkills,
    required this.onTapEducation,
    required this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xD90D0F14),
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            'kurt.dev',
            style: GoogleFonts.jetBrainsMono(
              color: AppColors.accent,
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          if (isWide)
            Row(
              children: [
                _NavLink('Experience', onTapExperience),
                _NavLink('Projects', onTapProjects),
                _NavLink('Skills', onTapSkills),
                _NavLink('Education', onTapEducation),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.muted),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2))),
          _MobileNavItem('Experience', onTapExperience, context),
          _MobileNavItem('Projects', onTapProjects, context),
          _MobileNavItem('Skills', onTapSkills, context),
          _MobileNavItem('Education', onTapEducation, context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BuildContext ctx;
  const _MobileNavItem(this.label, this.onTap, this.ctx);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: AppColors.textColor)),
      onTap: () {
        Navigator.pop(ctx);
        onTap();
      },
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: AppColors.muted,
              ),
              children: const [
                TextSpan(text: 'Kurt Andrei A. Gutierrez  ·  '),
                TextSpan(
                  text: 'kurtandrei50@gmail.com',
                  style: TextStyle(color: AppColors.accent),
                ),
                TextSpan(text: '  ·  +63 931 723 5372'),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Built with Flutter',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              color: AppColors.border,
            ),
          ),
        ],
      ),
    );
  }
}
