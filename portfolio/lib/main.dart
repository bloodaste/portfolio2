import 'package:flutter/material.dart';
import 'screens/portfolio_screen.dart';
import 'theme.dart';

void main() {
  runApp(const KurtPortfolioApp());
}

class KurtPortfolioApp extends StatelessWidget {
  const KurtPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurt Andrei Gutierrez — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const PortfolioScreen(),
    );
  }
}
