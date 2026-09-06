import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/stamp_passport_result.dart';
import '../../domain/usecases/stamp_passport_usecase.dart';
import 'providers/passport_provider.dart';

part 'stamp_pin_viewmodel.g.dart';

enum StampPinStatus {
  idle,
  loading,
  success,
  alreadyStamped,
  error,
}

class StampPinState {
  final StampPinStatus status;
  final StampPassportResult? result;
  final String? error;

  const StampPinState({
    this.status = StampPinStatus.idle,
    this.result,
    this.error,
  });

  bool get isLoading => status == StampPinStatus.loading;
  bool get isSuccess => status == StampPinStatus.success;
  bool get isAlreadyStamped => status == StampPinStatus.alreadyStamped;
  bool get hasError => status == StampPinStatus.error;

  StampPinState copyWith({
    StampPinStatus? status,
    StampPassportResult? result,
    String? error,
    bool clearResult = false,
    bool clearError = false,
  }) {
    return StampPinState(
      status: status ?? this.status,
      result: clearResult ? null : result ?? this.result,
      error: clearError ? null : error ?? this.error,
    );
  }
}

@riverpod
class StampPinViewModel extends _$StampPinViewModel {
  late final StampPassportUseCase _stampPassportUseCase;

  @override
  StampPinState build() {
    _stampPassportUseCase = ref.watch(stampPassportUseCaseProvider);
    return const StampPinState();
  }

  Future<void> scanPin(String pin) async {
    final normalizedPin = pin.trim();

    if (!RegExp(r'^\d{6}$').hasMatch(normalizedPin)) {
      state = const StampPinState(
        status: StampPinStatus.error,
        error: 'El PIN debe contener 6 dígitos.',
      );
      return;
    }

    if (state.isLoading) return;

    state = state.copyWith(
      status: StampPinStatus.loading,
      clearResult: true,
      clearError: true,
    );

    try {
      final result = await _stampPassportUseCase(
        pin: normalizedPin,
      );

      if (!result.success) {
        if (result.code == 'YA_SELLADO_HOY') {
          state = StampPinState(
            status: StampPinStatus.alreadyStamped,
            result: result,
            error: result.message ?? 'Este lugar ya fue sellado hoy.',
          );
          return;
        }

        state = StampPinState(
          status: StampPinStatus.error,
          result: result,
          error: result.message ?? 'No fue posible registrar el sello.',
        );
        return;
      }

      state = StampPinState(
        status: StampPinStatus.success,
        result: result,
      );
    } catch (error) {
      state = StampPinState(
        status: StampPinStatus.error,
        error: _friendlyError(error),
      );
    }
  }

  String _friendlyError(Object error) {
    final message = error.toString();

    if (message.contains('PIN inválido, expirado o inactivo')) {
      return 'El PIN es inválido, expiró o ya no está activo.';
    }

    return 'No fue posible registrar el sello. Inténtalo nuevamente.';
  }

  void reset() {
    state = const StampPinState();
  }
}
