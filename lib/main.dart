import 'package:famproject/features/contextual_cards/presentation/cubits/card_cubits.dart';
import 'package:famproject/features/contextual_cards/presentation/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  // Setup dependencies
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Contextual Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFBAF03)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F6F3),
      ),
      home: BlocProvider(
        create: (context) => getIt<CardsCubit>()..refreshCards(),
        child: const HomeScreen(),
      ),
    );
}
