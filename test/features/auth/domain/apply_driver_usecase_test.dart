import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tarcking_app/features/auth/domain/entities/apply_entites/driver_entity.dart';
import 'package:tarcking_app/features/auth/domain/usecases/apply/apply_driver_usecase.dart';
import '../mocks/mocks.dart';

void main() {
  late MockAuthRepo repo;
  late ApplyDriverUseCase usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = ApplyDriverUseCase(repo);
  });

  test('should call AuthRepo.applyDriver and return DriverEntity', () async {
    final entity = DriverEntity(
      id: "1",
      firstName: "Ahmed",
      lastName: "Naser",
      email: "ahmed@example.com",
      phone: "0100000000",
      country: "Egypt",
      vehicleType: "Car",
      vehicleNumber: "1234",
    );

    when(
      () => repo.applyDriver(
        country: any(named: 'country'),
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        vehicleType: any(named: 'vehicleType'),
        vehicleNumber: any(named: 'vehicleNumber'),
        vehicleLicensePath: any(named: 'vehicleLicensePath'),
        nid: any(named: 'nid'),
        nidImgPath: any(named: 'nidImgPath'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        rePassword: any(named: 'rePassword'),
        gender: any(named: 'gender'),
        phone: any(named: 'phone'),
      ),
    ).thenAnswer((_) async => entity);

    final result = await usecase(
      country: "Egypt",
      firstName: "Ahmed",
      lastName: "Naser",
      vehicleType: "Car",
      vehicleNumber: "1234",
      vehicleLicensePath: "path/license.png",
      nid: "0000",
      nidImgPath: "path/id.png",
      email: "ahmed@example.com",
      password: "12345678",
      rePassword: "12345678",
      gender: "Male",
      phone: "0100000000",
    );

    expect(result, isA<DriverEntity>());
    expect(result.firstName, "Ahmed");
  });
}
