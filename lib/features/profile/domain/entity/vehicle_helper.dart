import '../../../auth/data/models/apply_models/vehicles.dart';

class VehicleHelper {
  static final List<Vehicles> vehicles = [
    Vehicles(
      Id: "676b63c99f3884b3405c149b",
      type: "Motor Cycle",
      image:
          "https://flower.elevateegy.com/uploads/3be99805-65e0-4f05-9e98-4ccfb0b2ca5f-Chopper.png",
    ),
    Vehicles(
      Id: "676b63ef9f3884b3405c14a5",
      type: "Compact",
      image:
          "https://flower.elevateegy.com/uploads/663cb0ed-cc46-4b7c-99f4-d425e9f78437-Compact.png",
    ),
    Vehicles(
      Id: "676b63fc9f3884b3405c14ad",
      type: "Sedan",
      image:
          "https://flower.elevateegy.com/uploads/39bcda45-6ab6-45cc-9eda-a72c30947bd9-Sedan.png",
    ),
    Vehicles(
      Id: "676b640e9f3884b3405c14b5",
      type: "Semi",
      image:
          "https://flower.elevateegy.com/uploads/81814934-f55c-4ebd-8d57-dc8abd60623a-Semi.png",
    ),
    Vehicles(
      Id: "676b641c9f3884b3405c14bd",
      type: "Sports",
      image:
          "https://flower.elevateegy.com/uploads/eb29f197-b672-431b-8037-0bb1571df928-Sports.png",
    ),
    Vehicles(
      Id: "676b64279f3884b3405c14c5",
      type: "SUV",
      image:
          "https://flower.elevateegy.com/uploads/209b736d-8570-4f18-9ba5-2708859dda07-SUV.png",
    ),
    Vehicles(
      Id: "676b64349f3884b3405c14cd",
      type: "Truck",
      image:
          "https://flower.elevateegy.com/uploads/68b0117b-cb13-4d45-a0ef-0a3099581551-Truck.png",
    ),
    Vehicles(
      Id: "68dafed9dd8937e0574037ac",
      type: "676b31a45d05310ca82657ac",
      image:
          "https://flower.elevateegy.com/uploads/0d2024ac-a538-46cb-8281-f8e761471353-1212.png",
    ),
    Vehicles(
      Id: "68dafee9dd8937e0574037b0",
      type: "676b31a45d05310ca82657ac",
      image:
          "https://flower.elevateegy.com/uploads/c2eea43b-9080-4a14-ab44-3cf47566b55f-1212.png",
    ),
    Vehicles(
      Id: "68dafefadd8937e0574037b4",
      type: "676b31a45d05310ca82657ac",
      image:
          "https://flower.elevateegy.com/uploads/656083e2-fe5b-4cd9-8745-66e56c59b914-1212.png",
    ),
  ];

  static String? getVehicleTypeById(String id) {
    final vehicle = vehicles.firstWhere(
      (v) => v.Id == id,
      orElse: () => Vehicles(Id: "", type: "", image: ""),
    );
    return vehicle.Id != null ? vehicle.type : null;
  }
}
