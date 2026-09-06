import 'package:flutter/material.dart';

import '../../viewmodels/passport_viewmodel.dart';
import '../../widgets/codex/badge_grid_item.dart';
import '../../widgets/codex/cultural_content_card.dart';
import '../../widgets/common/neo_paper_container.dart';

class CodexTab extends StatefulWidget {
  final PassportState state;
  final Future<void> Function() onRefresh;

  const CodexTab({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  State<CodexTab> createState() => _CodexTabState();
}

class _CodexTabState extends State<CodexTab> {
  bool badges = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('Insignias'),
              ),
              ButtonSegment(
                value: false,
                label: Text('Relatos'),
              ),
            ],
            selected: {badges},
            onSelectionChanged: (value) {
              setState(() => badges = value.first);
            },
          ),
          const SizedBox(height: 18),

          if (widget.state.passportLoading &&
              widget.state.badges.isEmpty &&
              widget.state.culturalContents.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            )
          else if (widget.state.passportError != null &&
              widget.state.badges.isEmpty &&
              widget.state.culturalContents.isEmpty)
            NeoPaperContainer(
              child: Column(
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 38),
                  const SizedBox(height: 8),
                  const Text(
                    'No pudimos cargar el Códex.',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: widget.onRefresh,
                    child: const Text('REINTENTAR'),
                  ),
                ],
              ),
            )
          else if (badges)
            _BadgeCollection(state: widget.state)
          else
            _CulturalCollection(state: widget.state),
        ],
      ),
    );
  }
}

class _BadgeCollection extends StatelessWidget {
  final PassportState state;

  const _BadgeCollection({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final badges = state.badges;
    final unlocked = badges.where((badge) => badge.unlocked).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Colección de insignias',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF004046),
                ),
              ),
            ),
            Text(
              '$unlocked / ${badges.length}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFF8C5C58),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (badges.isEmpty)
          const NeoPaperContainer(
            child: Text(
              'Aún no hay insignias configuradas.',
              style: TextStyle(
                color: Color(0xFF8C5C58),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: badges.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: .72,
            ),
            itemBuilder: (_, index) {
              final badge = badges[index];

              return BadgeGridItem(
                nombre: badge.name,
                descripcion: badge.description,
                unlocked: badge.unlocked,
                iconUrl: badge.iconUrl,
                progreso: badge.unlocked
                    ? 'Desbloqueada'
                    : badge.requirementValue > 0
                        ? 'Meta: ${badge.requirementValue}'
                        : 'Bloqueada',
              );
            },
          ),
      ],
    );
  }
}

class _CulturalCollection extends StatelessWidget {
  final PassportState state;

  const _CulturalCollection({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final contents = state.culturalContents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contenido cultural',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF004046),
          ),
        ),
        const SizedBox(height: 10),

        if (contents.isEmpty)
          const NeoPaperContainer(
            child: Text(
              'Todavía no has desbloqueado relatos. '
              'Sigue explorando para ampliar tu Códex.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF8C5C58),
              ),
            ),
          )
        else
          ...contents.map(
            (content) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CulturalContentCard(
                titulo: content.title,
                tipo: content.contentType,
                resumen: content.description,
                imagenUrl: content.imageUrl,
                onTap: () => _showContent(
                  context,
                  content.title,
                  content.contentType,
                  content.description,
                  content.imageUrl,
                ),
              ),
            ),
          ),

        const SizedBox(height: 4),
        const NeoPaperContainer(
          child: Text(
            'El contenido se desbloquea progresivamente mediante '
            'tus visitas y el progreso de cada departamento.',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8C5C58),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showContent(
    BuildContext context,
    String title,
    String type,
    String description,
    String? imageUrl,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * .82,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFFBF8E3),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null && imageUrl.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  type.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF8C5C58),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF004046),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF8C5C58),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(sheetContext).pop(),
                    child: const Text('Cerrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
