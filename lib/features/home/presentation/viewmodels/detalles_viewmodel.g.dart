// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalles_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detallesViewModelHash() => r'f1b9234e88537ed7247e783e131f35377902a5bc';

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

abstract class _$DetallesViewModel
    extends BuildlessAutoDisposeAsyncNotifier<DestinationEntity?> {
  late final String? destinationId;

  FutureOr<DestinationEntity?> build(
    String? destinationId,
  );
}

/// See also [DetallesViewModel].
@ProviderFor(DetallesViewModel)
const detallesViewModelProvider = DetallesViewModelFamily();

/// See also [DetallesViewModel].
class DetallesViewModelFamily extends Family<AsyncValue<DestinationEntity?>> {
  /// See also [DetallesViewModel].
  const DetallesViewModelFamily();

  /// See also [DetallesViewModel].
  DetallesViewModelProvider call(
    String? destinationId,
  ) {
    return DetallesViewModelProvider(
      destinationId,
    );
  }

  @override
  DetallesViewModelProvider getProviderOverride(
    covariant DetallesViewModelProvider provider,
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
  String? get name => r'detallesViewModelProvider';
}

/// See also [DetallesViewModel].
class DetallesViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DetallesViewModel, DestinationEntity?> {
  /// See also [DetallesViewModel].
  DetallesViewModelProvider(
    String? destinationId,
  ) : this._internal(
          () => DetallesViewModel()..destinationId = destinationId,
          from: detallesViewModelProvider,
          name: r'detallesViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detallesViewModelHash,
          dependencies: DetallesViewModelFamily._dependencies,
          allTransitiveDependencies:
              DetallesViewModelFamily._allTransitiveDependencies,
          destinationId: destinationId,
        );

  DetallesViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.destinationId,
  }) : super.internal();

  final String? destinationId;

  @override
  FutureOr<DestinationEntity?> runNotifierBuild(
    covariant DetallesViewModel notifier,
  ) {
    return notifier.build(
      destinationId,
    );
  }

  @override
  Override overrideWith(DetallesViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetallesViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DetallesViewModel, DestinationEntity?>
      createElement() {
    return _DetallesViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetallesViewModelProvider &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, destinationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetallesViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<DestinationEntity?> {
  /// The parameter `destinationId` of this provider.
  String? get destinationId;
}

class _DetallesViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetallesViewModel,
        DestinationEntity?> with DetallesViewModelRef {
  _DetallesViewModelProviderElement(super.provider);

  @override
  String? get destinationId =>
      (origin as DetallesViewModelProvider).destinationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
