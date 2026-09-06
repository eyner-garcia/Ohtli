import 'package:flutter/material.dart';

import '../../../domain/entities/stamp_passport_result.dart';

enum StampSuccessAction {
  close,
  openWallet,
}

Future<StampSuccessAction?> showStampSuccessDialog(
  BuildContext context,
  StampPassportResult result,
) {
  return showDialog<StampSuccessAction>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFBF8E3),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_rounded,
                  size: 20,
                  color: Color(0xFF8C5C58),
                ),
                SizedBox(width: 7),
                Text(
                  'SELLO COLOCADO',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF8C5C58),
                  width: 5,
                ),
              ),
              child: const Icon(
                Icons.workspace_premium_rounded,
                size: 60,
                color: Color(0xFF8C5C58),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              result.firstVisit
                  ? '¡Nuevo descubrimiento!'
                  : '¡Visita registrada!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '+${result.xpEarned} XP',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color(0xFF84A98C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'XP total: ${result.totalXp}',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8C5C58),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (result.rewardUnlocked && result.reward != null) ...[
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard_rounded,
                    size: 18,
                    color: Color(0xFF8C5C58),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'RECOMPENSA DESBLOQUEADA',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                result.reward!.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              if (result.reward!.benefitDescription != null)
                Text(
                  result.reward!.benefitDescription!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8C5C58),
                  ),
                ),
            ],
            const SizedBox(height: 14),
            if (result.rewardUnlocked && result.reward != null)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(
                      StampSuccessAction.openWallet,
                    );
                  },
                  child: const Text('VER EN ALFORJA'),
                ),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  StampSuccessAction.close,
                );
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    ),
  );
}
