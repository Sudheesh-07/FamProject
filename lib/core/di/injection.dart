import 'package:famproject/features/contextual_cards/data/models/card_action_model.dart';
import 'package:famproject/features/contextual_cards/data/repositories/card_repository_impl.dart';
import 'package:famproject/features/contextual_cards/domain/repositories/card_repository.dart';
import 'package:famproject/features/contextual_cards/presentation/cubits/card_cubits.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(CardActionModelAdapter());

  // Open boxes
  await Hive.openBox<CardActionModel>('card_actions');

  // Register Repository
  getIt.registerLazySingleton<CardRepository>(() => CardRepositoryImpl());

  // Register Cubit
  getIt.registerFactory<CardsCubit>(() => CardsCubit(getIt<CardRepository>()));
}
