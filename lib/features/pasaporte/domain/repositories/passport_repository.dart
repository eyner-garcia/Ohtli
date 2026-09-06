import '../entities/department_poi.dart';
import '../entities/passport_snapshot.dart';
import '../entities/reward_redemption.dart';
import '../entities/stamp_passport_result.dart';

abstract class PassportRepository {
  Future<StampPassportResult> stampPassport({
    required String pin,
  });

  Future<List<RewardRedemption>> getRewardRedemptions();

  Future<PassportSnapshot> getPassportSnapshot();

  Future<List<DepartmentPoi>> getDepartmentPois({
    required String departmentId,
  });
}
