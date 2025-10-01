import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/card_action_model.dart';
import '../../data/repositories/card_repository_impl.dart';
import '../../domain/repositories/card_repository.dart';
import '../../presentation/cubits/cards_cubit.dart';

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
