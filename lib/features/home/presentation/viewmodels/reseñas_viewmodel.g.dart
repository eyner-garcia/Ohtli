// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reseñas_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resenasViewModelHash() => r'6d92a10742ce0b482f907b4e84024269af2645ce';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ResenasViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<ReviewEntity>> {
  late final String destinationId;

  FutureOr<List<ReviewEntity>> build(
    String destinationId,
  );
}

/// See also [ResenasViewModel].
@ProviderFor(ResenasViewModel)
const resenasViewModelProvider = ResenasViewModelFamily();

/// See also [ResenasViewModel].
class ResenasViewModelFamily extends Family<AsyncValue<List<ReviewEntity>>> {
  /// See also [ResenasViewModel].
  const ResenasViewModelFamily();

  /// See also [ResenasViewModel].
  ResenasViewModelProvider call(
    String destinationId,
  ) {
    return ResenasViewModelProvider(
      destinationId,
    );
  }

  @override
  ResenasViewModelProvider getProviderOverride(
    covariant ResenasViewModelProvider provider,
  ) {
    return call(
      provider.destinationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'resenasViewModelProvider';
}

/// See also [ResenasViewModel].
class ResenasViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ResenasViewModel, List<ReviewEntity>> {
  /// See also [ResenasViewModel].
  ResenasViewModelProvider(
    String destinationId,
  ) : this._internal(
          () => ResenasViewModel()..destinationId = destinationId,
          from: resenasViewModelProvider,
          name: r'resenasViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resenasViewModelHash,
          dependencies: ResenasViewModelFamily._dependencies,
          allTransitiveDependencies:
              ResenasViewModelFamily._allTransitiveDependencies,
          destinationId: destinationId,
        );

  ResenasViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.destinationId,
  }) : super.internal();

  final String destinationId;

  @override
  FutureOr<List<ReviewEntity>> runNotifierBuild(
    covariant ResenasViewModel notifier,
  ) {
    return notifier.build(
      destinationId,
    );
  }

  @override
  Override overrideWith(ResenasViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResenasViewModelProvider._internal(
        () => create()..destinationId = destinationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        destinationId: destinationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ResenasViewModel, List<ReviewEntity>>
      createElement() {
    return _ResenasViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResenasViewModelProvider &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, destinationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ResenasViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<ReviewEntity>> {
  /// The parameter `destinationId` of this provider.
  String get destinationId;
}

class _ResenasViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ResenasViewModel,
        List<ReviewEntity>> with ResenasViewModelRef {
  _ResenasViewModelProviderElement(super.provider);

  @override
  String get destinationId =>
      (origin as ResenasViewModelProvider).destinationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
