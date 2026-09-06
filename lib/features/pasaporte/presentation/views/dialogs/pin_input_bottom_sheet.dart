import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodels/stamp_pin_viewmodel.dart';

Future<void> showPinInputBottomSheet({
  required BuildContext context,
  required VoidCallback onSuccess,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _PinInput(
      onSuccess: onSuccess,
    ),
  );
}

class _PinInput extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;

  const _PinInput({
    required this.onSuccess,
  });

  @override
  ConsumerState<_PinInput> createState() => _PinInputState();
}

class _PinInputState extends ConsumerState<_PinInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ref.read(
        stampPinViewModelProvider.notifier,
      ).reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pin = _controller.text.trim();

    if (pin.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El PIN debe contener 6 dígitos.'),
        ),
      );
      return;
    }

    final viewModel = ref.read(
      stampPinViewModelProvider.notifier,
    );

    await viewModel.scanPin(pin);

    if (!mounted) return;

    final resultState = ref.read(
      stampPinViewModelProvider,
    );

    if (!resultState.isSuccess) return;

    Navigator.of(context).pop();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSuccess();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      stampPinViewModelProvider,
    );

    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFFBF8E3),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SELLAR VISITA',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),

              const Text(
                'Ingresa el PIN del establecimiento',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _controller,
                autofocus: true,
                enabled: !state.isLoading,
                maxLength: 6,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                textAlign: TextAlign.center,
                onSubmitted: (_) {
                  if (!state.isLoading) {
                    _submit();
                  }
                },
                decoration: const InputDecoration(
                  hintText: '••••••',
                  counterText: '',
                ),
                style: const TextStyle(
                  fontSize: 28,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                ),
              ),

              if (state.hasError ||
                  state.isAlreadyStamped) ...[
                const SizedBox(height: 8),

                Text(
                  state.error ??
                      'No fue posible registrar el sello.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isLoading
                      ? null
                      : _submit,
                  child: state.isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'CONFIRMAR SELLO',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}