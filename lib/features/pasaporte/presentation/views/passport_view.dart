import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/passport_viewmodel.dart';
import '../viewmodels/providers/passport_provider.dart';

import '../viewmodels/stamp_pin_viewmodel.dart';
import '../widgets/common/neo_paper_container.dart';
import '../widgets/common/stamp_action_fab.dart';
import '../widgets/header/user_level_card.dart';
import '../widgets/header/passport_tab_bar.dart';

import 'department_detail_view.dart';
import 'dialogs/pin_input_bottom_sheet.dart';
import 'dialogs/stamp_success_dialog.dart';

import 'tabs/passport_progress_tab.dart';
import 'tabs/codex_tab.dart';
import 'tabs/alforja_tab.dart';

class PassportView extends ConsumerStatefulWidget {
  const PassportView({
    super.key,
  });

  @override
  ConsumerState<PassportView> createState() => _PassportViewState();
}

class _PassportViewState extends ConsumerState<PassportView>
    with SingleTickerProviderStateMixin {
  late final TabController tabs;

  @override
  void initState() {
    super.initState();

    final passportState = ref.read(
      passportViewModelProvider,
    );

    tabs = TabController(
      length: 3,
      vsync: this,
      initialIndex: passportState.tab.index,
    );

    tabs.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (tabs.indexIsChanging) return;

    ref
        .read(passportViewModelProvider.notifier)
        .setTab(
      PassportTab.values[tabs.index],
    );
  }

  @override
  void dispose() {
    tabs.removeListener(_onTabChanged);
    tabs.dispose();
    super.dispose();
  }

  Future<void> _stamp() async {
    await showPinInputBottomSheet(
      context: context,
      onSuccess: _success,
    );
  }

  Future<void> _success() async {
    final stampState = ref.read(
      stampPinViewModelProvider,
    );

    final result = stampState.result;

    if (result == null || !mounted) return;

    ref
        .read(passportViewModelProvider.notifier)
        .applyStamp(result);

    final action = await showStampSuccessDialog(
      context,
      result,
    );

    if (!mounted) return;

    if (action == StampSuccessAction.openWallet) {
      final passportViewModel = ref.read(
        passportViewModelProvider.notifier,
      );

      passportViewModel.setTab(PassportTab.alforja);

      if (tabs.index != PassportTab.alforja.index) {
        tabs.animateTo(PassportTab.alforja.index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final passportState = ref.watch(
      passportViewModelProvider,
    );

    return Scaffold(
      backgroundColor: PassportPalette.parchment,

      floatingActionButton: StampActionFab(
        onPressed: _stamp,
      ),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                14,
                18,
                10,
              ),
              child: Column(
                children: [
                  UserLevelCard(
                    userName: passportState.userName,
                    photoUrl: passportState.photoUrl,
                    nivel: passportState.nivel,
                    xpTotal: passportState.xpTotal,
                    xpSiguienteNivel: passportState.nivel * 500,
                  ),

                  const SizedBox(height: 12),

                  PassportTabBar(
                    selected: passportState.tab,
                    hasReward: passportState.recompensaDisponible != null ||
                        passportState.rewardRedemptions.any(
                          (reward) => reward.isAvailable,
                        ),
                    onChanged: (tab) {
                      ref
                          .read(
                        passportViewModelProvider.notifier,
                      )
                          .setTab(tab);

                      tabs.animateTo(
                        tab.index,
                      );
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: tabs,
                children: [
                  PassportProgressTab(
                    state: passportState,
                    onRefresh: () => ref
                        .read(passportViewModelProvider.notifier)
                        .loadPassport(),
                    onDepartmentTap: (department) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DepartmentDetailView(
                                department: department,
                              ),
                        ),
                      );
                    },
                  ),

                  CodexTab(
                    state: passportState,
                    onRefresh: () => ref
                        .read(passportViewModelProvider.notifier)
                        .loadPassport(),
                  ),

                  AlforjaTab(
                    rewards: passportState.rewardRedemptions,
                    isLoading: passportState.walletLoading,
                    error: passportState.walletError,
                    onRefresh: () => ref
                        .read(passportViewModelProvider.notifier)
                        .loadWallet(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}