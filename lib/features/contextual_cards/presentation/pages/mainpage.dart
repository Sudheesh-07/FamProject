import 'package:famproject/features/contextual_cards/presentation/widgets/contextual_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
        'assets/images/fampaylogo.svg',
        fit: BoxFit.contain,
      ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const ContextualCardsContainer(),
    );
}
