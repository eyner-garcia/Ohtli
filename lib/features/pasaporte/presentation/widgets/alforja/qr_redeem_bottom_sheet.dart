import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../domain/entities/reward_redemption.dart';

Future<void> showQrRedeemBottomSheet(
  BuildContext context,
  RewardRedemption redemption,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      final screen = MediaQuery.sizeOf(sheetContext);

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screen.height * .88,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFBF8E3),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final qrSize = math.min(
                  190.0,
                  constraints.maxWidth - 56,
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8C5C58),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'MOSTRAR CANJE',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8C5C58),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      redemption.reward.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8C5C58),
                      ),
                    ),
                    if (redemption.reward.benefitDescription !=
                        null) ...[
                      const SizedBox(height: 5),
                      Text(
                        redemption.reward.benefitDescription!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C5C58),
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            offset: Offset(0, 5),
                            color: Color(0x22000000),
                          ),
                        ],
                      ),
                      child: QrImageView(
                        data: redemption.redemptionCode,
                        version: QrVersions.auto,
                        size: qrSize,
                        backgroundColor: Colors.white,
                        errorCorrectionLevel:
                            QrErrorCorrectLevel.M,
                        gapless: true,
                        semanticsLabel:
                            'Código QR de canje '
                            '${redemption.redemptionCode}',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'CÓDIGO DE CANJE',
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF8C5C58),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      redemption.redemptionCode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8C5C58),
                      ),
                    ),
                    if (redemption.expiresAt != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Válido hasta '
                        '${_formatDate(redemption.expiresAt!)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8C5C58),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    const Text(
                      'Muestra este QR en el establecimiento. '
                      'El código impreso queda como respaldo para '
                      'validación manual.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color: Color(0xFF8C5C58),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(sheetContext).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}
