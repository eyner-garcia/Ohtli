import 'package:flutter/material.dart';

import '../../viewmodels/passport_viewmodel.dart';
import '../common/neo_paper_container.dart';

class PassportTabBar extends StatelessWidget {
  final PassportTab selected;
  final ValueChanged<PassportTab> onChanged;
  final bool hasReward;

  const PassportTabBar({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.hasReward,
  });

  @override
  Widget build(BuildContext context) {
    return NeoPaperContainer(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: PassportTab.values.map((tab) {
          final active = tab == selected;
          final isWallet = tab == PassportTab.alforja;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => onChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? PassportPalette.parchment
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _iconFor(tab),
                          size: 17,
                          color: active
                              ? PassportPalette.leatherDark
                              : PassportPalette.muted,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            _labelFor(tab),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: active
                                  ? PassportPalette.leatherDark
                                  : PassportPalette.muted,
                              fontSize: 12,
                              fontWeight: active
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isWallet && hasReward)
                      const Positioned(
                        right: 8,
                        top: -3,
                        child: _RewardDot(),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _iconFor(PassportTab tab) {
    switch (tab) {
      case PassportTab.progress:
        return Icons.explore_outlined;
      case PassportTab.codex:
        return Icons.menu_book_rounded;
      case PassportTab.alforja:
        return Icons.card_giftcard_rounded;
    }
  }

  String _labelFor(PassportTab tab) {
    switch (tab) {
      case PassportTab.progress:
        return 'Progreso';
      case PassportTab.codex:
        return 'Códex';
      case PassportTab.alforja:
        return 'Alforja';
    }
  }
}

class _RewardDot extends StatelessWidget {
  const _RewardDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: PassportPalette.reward,
        shape: BoxShape.circle,
      ),
    );
  }
}
