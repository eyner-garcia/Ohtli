import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cultural_content.dart';
import '../../domain/entities/passport_snapshot.dart';
import '../../domain/entities/reward_unlocked.dart';
import '../../domain/entities/reward_redemption.dart';
import '../../domain/entities/stamp_passport_result.dart';
import 'providers/passport_provider.dart';

part 'passport_viewmodel.g.dart';

enum PassportTab {
  progress,
  codex,
  alforja,
}

class PassportDepartmentState {
  final String id;
  final String nombre;
  final int porcentaje;
  final bool completado;
  final int visitas;
  final int descubrimientos;

  const PassportDepartmentState({
    required this.id,
    required this.nombre,
    required this.porcentaje,
    required this.completado,
    this.visitas = 0,
    this.descubrimientos = 0,
  });

  PassportDepartmentState copyWith({
    String? id,
    String? nombre,
    int? porcentaje,
    bool? completado,
    int? visitas,
    int? descubrimientos,
  }) {
    return PassportDepartmentState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      porcentaje: porcentaje ?? this.porcentaje,
      completado: completado ?? this.completado,
      visitas: visitas ?? this.visitas,
      descubrimientos: descubrimientos ?? this.descubrimientos,
    );
  }
}

class PassportState {
  final PassportTab tab;
  final String userName;
  final String? photoUrl;
  final int xpTotal;
  final int nivel;
  final int totalSellos;
  final int departamentosDescubiertos;
  final RewardUnlocked? recompensaDisponible;

  final PassportDepartmentState? departamentoActual;
  final List<PassportDepartmentState> departamentos;

  final List<PassportBadgeSnapshot> badges;
  final List<CulturalContent> culturalContents;

  final List<RewardRedemption> rewardRedemptions;

  final bool passportLoading;
  final String? passportError;

  final bool walletLoading;
  final String? walletError;

  const PassportState({
    this.tab = PassportTab.progress,
    this.userName = 'Usuario',
    this.photoUrl,
    this.xpTotal = 0,
    this.nivel = 1,
    this.totalSellos = 0,
    this.departamentosDescubiertos = 0,
    this.recompensaDisponible,
    this.departamentoActual,
    this.departamentos = const [],
    this.badges = const [],
    this.culturalContents = const [],
    this.rewardRedemptions = const [],
    this.passportLoading = false,
    this.passportError,
    this.walletLoading = false,
    this.walletError,
  });

  PassportState copyWith({
    PassportTab? tab,
    String? userName,
    String? photoUrl,
    int? xpTotal,
    int? nivel,
    int? totalSellos,
    int? departamentosDescubiertos,
    RewardUnlocked? recompensaDisponible,
    PassportDepartmentState? departamentoActual,
    List<PassportDepartmentState>? departamentos,
    List<PassportBadgeSnapshot>? badges,
    List<CulturalContent>? culturalContents,
    List<RewardRedemption>? rewardRedemptions,
    bool? passportLoading,
    String? passportError,
    bool? walletLoading,
    String? walletError,
    bool clearPassportError = false,
    bool clearWalletError = false,
    bool clearReward = false,
    bool clearDepartment = false,
  }) {
    return PassportState(
      tab: tab ?? this.tab,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      xpTotal: xpTotal ?? this.xpTotal,
      nivel: nivel ?? this.nivel,
      totalSellos: totalSellos ?? this.totalSellos,
      departamentosDescubiertos:
          departamentosDescubiertos ?? this.departamentosDescubiertos,
      recompensaDisponible: clearReward
          ? null
          : recompensaDisponible ?? this.recompensaDisponible,
      departamentoActual: clearDepartment
          ? null
          : departamentoActual ?? this.departamentoActual,
      departamentos: departamentos ?? this.departamentos,
      badges: badges ?? this.badges,
      culturalContents: culturalContents ?? this.culturalContents,
      rewardRedemptions:
          rewardRedemptions ?? this.rewardRedemptions,
      passportLoading: passportLoading ?? this.passportLoading,
      passportError: clearPassportError
          ? null
          : passportError ?? this.passportError,
      walletLoading: walletLoading ?? this.walletLoading,
      walletError:
          clearWalletError ? null : walletError ?? this.walletError,
    );
  }
}

@riverpod
class PassportViewModel extends _$PassportViewModel {
  @override
  PassportState build() {
    Future.microtask(refreshAll);
    return const PassportState();
  }

  Future<void> refreshAll() async {
    await Future.wait([
      loadPassport(),
      loadWallet(),
    ]);
  }

  Future<void> loadPassport() async {
    state = state.copyWith(
      passportLoading: true,
      clearPassportError: true,
    );

    try {
      final snapshot = await ref
          .read(passportRepositoryProvider)
          .getPassportSnapshot();

      final departments = snapshot.departments
          .map(
            (department) => PassportDepartmentState(
              id: department.id,
              nombre: department.name,
              porcentaje: department.percentage,
              completado: department.completed,
              visitas: department.visits,
              descubrimientos: department.discoveries,
            ),
          )
          .toList();

      final discovered = departments
          .where((department) => department.porcentaje > 0)
          .length;

      state = state.copyWith(
        userName: snapshot.userName,
        photoUrl: snapshot.photoUrl,
        xpTotal: snapshot.xpTotal,
        nivel: _levelForXp(snapshot.xpTotal),
        totalSellos: snapshot.totalStamps,
        departamentosDescubiertos: discovered,
        departamentos: departments,
        badges: snapshot.badges,
        culturalContents: snapshot.culturalContents,
        passportLoading: false,
        clearPassportError: true,
      );
    } catch (error, stackTrace) {
      debugPrint('🔥 PASSPORT SNAPSHOT ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      state = state.copyWith(
        passportLoading: false,
        passportError: error.toString(),
      );
    }
  }

  Future<void> loadWallet() async {
    state = state.copyWith(
      walletLoading: true,
      clearWalletError: true,
    );

    try {
      final rewards = await ref
          .read(passportRepositoryProvider)
          .getRewardRedemptions();

      state = state.copyWith(
        rewardRedemptions: rewards,
        walletLoading: false,
        clearWalletError: true,
      );
    } catch (error) {
      state = state.copyWith(
        walletLoading: false,
        walletError: error.toString(),
      );
    }
  }

  void setTab(PassportTab tab) {
    if (state.tab == tab) return;
    state = state.copyWith(tab: tab);
  }

  void applyStamp(StampPassportResult result) {
    if (!result.success) return;

    var departamentosDescubiertos =
        state.departamentosDescubiertos;

    final department = result.department;

    if (department != null &&
        department.previousPercentage == 0 &&
        department.currentPercentage > 0) {
      departamentosDescubiertos++;
    }

    PassportDepartmentState? departamentoActual;

    if (department != null) {
      departamentoActual = _updateDepartment(
        department.id,
        department.currentPercentage,
        department.completed,
      );
    }

    state = state.copyWith(
      xpTotal: result.totalXp,
      nivel: _levelForXp(result.totalXp),
      totalSellos: state.totalSellos + 1,
      departamentosDescubiertos: departamentosDescubiertos,
      departamentoActual: departamentoActual,
      recompensaDisponible:
          result.rewardUnlocked ? result.reward : null,
    );
    Future.microtask(refreshAll);
  }

  PassportDepartmentState? _updateDepartment(
    String departmentId,
    int percentage,
    bool completed,
  ) {
    final index = state.departamentos.indexWhere(
      (department) => department.id == departmentId,
    );

    if (index == -1) return null;

    final current = state.departamentos[index];

    final updated = current.copyWith(
      porcentaje: percentage,
      completado: completed,
      visitas: current.visitas + 1,
      descubrimientos: current.descubrimientos +
          (percentage > current.porcentaje ? 1 : 0),
    );

    final updatedDepartments = [
      ...state.departamentos,
    ];

    updatedDepartments[index] = updated;

    state = state.copyWith(
      departamentos: updatedDepartments,
    );

    return updated;
  }

  int _levelForXp(int xp) {
    return (xp ~/ 500) + 1;
  }

  void clearReward() {
    state = state.copyWith(clearReward: true);
  }

  void clearDepartment() {
    state = state.copyWith(clearDepartment: true);
  }

  void reset() {
    state = const PassportState();
    Future.microtask(refreshAll);
  }
}
