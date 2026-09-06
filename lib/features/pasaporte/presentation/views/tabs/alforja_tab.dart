import 'package:flutter/material.dart';

import '../../../domain/entities/reward_redemption.dart';
import '../../widgets/alforja/qr_redeem_bottom_sheet.dart';
import '../../widgets/alforja/reward_card.dart';
import '../../widgets/common/neo_paper_container.dart';

class AlforjaTab extends StatelessWidget {
  final List<RewardRedemption> rewards;
  final bool isLoading;
  final String? error;
  final Future<void> Function() onRefresh;

  const AlforjaTab({
    super.key,
    required this.rewards,
    required this.isLoading,
    required this.error,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final available = rewards.where((r) => r.isAvailable).toList();
    final history = rewards.where((r) => !r.isAvailable).toList();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
        children: [
          const Text(
            'Tu Alforja',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: PassportPalette.ink,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Recompensas desbloqueadas listas para canjear.',
            style: TextStyle(color: PassportPalette.muted),
          ),
          const SizedBox(height: 18),

          if (isLoading && rewards.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: CircularProgressIndicator(),
              ),
            )
          else if (error != null && rewards.isEmpty)
            NeoPaperContainer(
              child: Column(
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 38),
                  const SizedBox(height: 8),
                  const Text(
                    'No pudimos cargar tu Alforja.',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onRefresh,
                    child: const Text('REINTENTAR'),
                  ),
                ],
              ),
            )
          else if (available.isEmpty)
            const NeoPaperContainer(
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard_outlined,
                    size: 42,
                    color: PassportPalette.locked,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tu Alforja está esperando.',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Sella visitas para desbloquear recompensas.',
                    style: TextStyle(
                      fontSize: 11,
                      color: PassportPalette.muted,
                    ),
                  ),
                ],
              ),
            )
          else
            ...available.expand(
              (redemption) => [
                RewardCard(
                  reward: redemption.reward,
                  onRedeem: () => showQrRedeemBottomSheet(
                    context,
                    redemption,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),

          const SizedBox(height: 12),
          const Text(
            'Historial',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: PassportPalette.ink,
            ),
          ),
          const SizedBox(height: 10),

          if (history.isEmpty)
            const NeoPaperContainer(
              child: Text(
                'Tus recompensas utilizadas aparecerán aquí.',
                style: TextStyle(color: PassportPalette.muted),
              ),
            )
          else
            ...history.map(
              (redemption) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: NeoPaperContainer(
                  child: Row(
                    children: [
                      const Icon(Icons.history_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              redemption.reward.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              redemption.status.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: PassportPalette.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
