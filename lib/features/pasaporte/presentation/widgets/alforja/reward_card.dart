import 'package:flutter/material.dart';

import '../../../domain/entities/reward_unlocked.dart';
import '../common/neo_paper_container.dart';

class RewardCard extends StatelessWidget {
  final RewardUnlocked reward;
  final VoidCallback onRedeem;

  const RewardCard({
    super.key,
    required this.reward,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onRedeem,
    borderRadius: BorderRadius.circular(24),
    child: NeoPaperContainer(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.card_giftcard_rounded,
                size: 16,
                color: PassportPalette.leather,
              ),
              SizedBox(width: 6),
              Text(
                'RECOMPENSA OHTLI',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w900,
                  color: PassportPalette.leather,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            reward.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: PassportPalette.ink,
            ),
          ),
          if (reward.benefitDescription != null)
            Text(
              reward.benefitDescription!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: PassportPalette.leather,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Toca para mostrar tu código de canje',
            style: TextStyle(
              fontSize: 11,
              color: PassportPalette.muted,
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: onRedeem,
            child: const Text('MOSTRAR CANJE'),
          ),
        ],
      ),
    ),
  );
}