import '../../domain/entities/department_poi.dart';
import '../../domain/entities/passport_snapshot.dart';
import '../../domain/entities/reward_redemption.dart';
import '../../domain/entities/stamp_passport_result.dart';
import '../../domain/repositories/passport_repository.dart';
import '../datasources/passport_remote_datasource.dart';

class PassportRepositoryImpl implements PassportRepository {
  final PassportRemoteDataSource remoteDataSource;

  const PassportRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<StampPassportResult> stampPassport({
    required String pin,
  }) {
    return remoteDataSource.stampPassport(pin: pin);
  }

  @override
  Future<List<RewardRedemption>> getRewardRedemptions() {
    return remoteDataSource.getRewardRedemptions();
  }

  @override
  Future<PassportSnapshot> getPassportSnapshot() {
    return remoteDataSource.getPassportSnapshot();
  }

  @override
  Future<List<DepartmentPoi>> getDepartmentPois({
    required String departmentId,
  }) {
    return remoteDataSource.getDepartmentPois(
      departmentId: departmentId,
    );
  }
}
