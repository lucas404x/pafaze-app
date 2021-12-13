import 'package:flutter/material.dart';

import '../data/models/pinned_card_model.dart';

class PinnedCard extends StatelessWidget {
  final PinnedCardModel pinnedCardModel;

  const PinnedCard({Key? key, required this.pinnedCardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF262626).withOpacity(.78),
            const Color(0xFF2C2C2C)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: pinnedCardModel.progressValue,
                color: Colors.white,
                backgroundColor: Colors.grey[600],
              ),
              Text(
                pinnedCardModel.tasksDonePercent.toString() + '%',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            'DE ${pinnedCardModel.totalTasksQuantity} TAREFAS ${pinnedCardModel.tasksDoneQuantity} FORAM CONCLUÍDAS',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
