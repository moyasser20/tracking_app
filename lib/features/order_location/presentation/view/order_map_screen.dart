import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tarcking_app/features/order_location/presentation/view/widgets/order_map_bottom_sheet_widget.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../order_details/data/models/order_details_model.dart';

class OrderMapScreen extends StatefulWidget {
  final OrderDetails order;
  final bool isFromPickupRoute;

  const OrderMapScreen({
    super.key,
    required this.order,
    required this.isFromPickupRoute,
  });

  @override
  State<OrderMapScreen> createState() => _OrderMapScreenState();
}

class _OrderMapScreenState extends State<OrderMapScreen>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  final LatLng _userLocation = const LatLng(30.046578, 31.235374);
  final LatLng _storeLocation = const LatLng(30.048026, 31.241605);
  final List<LatLng> _routePoints = [];
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _setupRoute();
    _setupMarkers();
  }

  void _setupRoute() {
    _routePoints.addAll([
      _userLocation,
      const LatLng(30.046578, 31.235374),
      const LatLng(30.046614, 31.241001),
      const LatLng(30.047503, 31.240820),
      const LatLng(30.048026, 31.241605),
      _storeLocation,
    ]);
  }

  void _setupMarkers() {
    _markers.addAll([
      Marker(
        width: 80.0,
        point: _userLocation,
        child: Builder(
          builder: (context) {
            final local = AppLocalizations.of(context)!;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          AppIcons.flowerHomeIcon,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Text(
                        local.apartmentLabel,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      Marker(
        width: 70.0,
        point: _storeLocation,
        child: Builder(
          builder: (context) {
            final local = AppLocalizations.of(context)!;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          AppIcons.floweryIcon,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      Text(
                        local.storeLabel,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _calculateMapCenter(),
              initialZoom: 16.0,
              maxZoom: 18.0,
              minZoom: 6.0,
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                doubleTapZoomDuration: Duration(milliseconds: 100),
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.flower_app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: AppColors.pink,
                    strokeWidth: 2.0,
                  ),
                ],
              ),
              MarkerLayer(markers: _markers),
            ],
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: IconButton(
                tooltip: local.backButtonTooltip,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                  size: 20,
                ),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: OrderMapBottomSheetWidget(
              order: widget.order,
              showPickupFirst: widget.isFromPickupRoute,
              onCallPressed: (phoneNumber) {
                _callNumber(phoneNumber);
              },
              onWhatsAppPressed: (phoneNumber) {
                _shareViaWhatsApp(phoneNumber);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _callNumber(String phoneNumber) async {
    final url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch phone app");
    }
  }

  void _shareViaWhatsApp(String phoneNumber) async {
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final phone = cleanedPhone.startsWith('+') ? cleanedPhone : '+$cleanedPhone';
    final url = Uri.parse("https://wa.me/$phone");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final phoneUrl = Uri.parse("tel:$phone");
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      }
    }
  }

  LatLng _calculateMapCenter() {
    double avgLat = (_userLocation.latitude + _storeLocation.latitude) / 2;
    double avgLng = (_userLocation.longitude + _storeLocation.longitude) / 2;
    return LatLng(avgLat, avgLng);
  }
}
