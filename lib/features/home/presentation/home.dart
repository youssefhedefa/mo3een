import 'package:flutter/material.dart';
import 'package:mo3een/core/components/widgets/bottom_nav_bar.dart';


class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: AppBottomNavBar(),
    );
  }
}