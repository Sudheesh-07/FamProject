import 'package:famproject/features/contextual_cards/presentation/cubits/card_cubits.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/card_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main Container - Plug and Play Component
class ContextualCardsContainer extends StatelessWidget {
  const ContextualCardsContainer({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CardsCubit, CardsState>(
    builder: (BuildContext context, CardsState state) {
      if (state is CardsLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is CardsError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<CardsCubit>().loadCards();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (state is CardsLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<CardsCubit>().refreshCards();
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.cardGroups.length,
            itemBuilder: (BuildContext context, int index) =>
                CardGroupWidget(cardGroup: state.cardGroups[index]),
          ),
        );
      }

      return const SizedBox.shrink();
    },
  );
}
