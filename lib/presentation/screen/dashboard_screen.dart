import 'package:adhan/adhan.dart';
import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _location = "Mengambil lokasi...";
  String _prayerName = "Loading...";
  String _prayerTime = "Loading...";
  String _backgroundImage = 'assets/images/bg_header_dashboard_morning.png';

  @override
  void initState() {
    super.initState();
    _updatePrayerTimes();
  }

  Future<void> _updatePrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;

      final myCoordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      final now = DateTime.now();

      // Find the next prayer time
      Prayer nextPrayer = prayerTimes.nextPrayer();
      DateTime? nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);

      setState(() {
        _location = "${place.subAdministrativeArea}, ${place.locality}";
        _prayerName = nextPrayer.toString().split('.').last;
        _prayerTime = nextPrayerTime != null
            ? DateFormat.jm().format(nextPrayerTime)
            : "N/A";
        _backgroundImage = _getBackgroundImage(now);
      });
    } catch (e) {
      setState(() {
        _location = "Lokasi tidak tersedia";
        _prayerName = "Error";
        _prayerTime = "Error";
      });
      print("Error obtaining location: $e");
    }
  }

  String _getBackgroundImage(DateTime now) {
    int hour = now.hour;
    if (hour < 12) {
      return 'assets/images/bg_header_dashboard_morning.png';
    } else if (hour < 18) {
      return 'assets/images/bg_header_dashboard_afternoon.png';
    } else {
      return 'assets/images/bg_header_dashboard_night.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorConstant.colorWhite,
                ),
                child: Text(
                  "Assalamualaikum Fulan",
                  style: TextStyle(
                    color: ColorConstant.colorText,
                    fontFamily: 'PoppinsMedium',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              _prayerName,
              style: TextStyle(
                color: ColorConstant.colorText,
                fontSize: 16,
                fontFamily: 'PoppinsMedium',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _prayerTime,
              style: TextStyle(
                color: ColorConstant.colorText,
                fontSize: 26,
                fontFamily: 'PoppinsBold',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: ColorConstant.colorPrimary,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  _location,
                  style: TextStyle(
                    color: ColorConstant.colorText,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget cardMenus() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          color: ColorConstant.colorPrimary,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'doa');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ic_menu_doa.png',
                    ),
                    Text(
                      "Doa-doa",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: ColorConstant.colorWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'zakat');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ic_menu_zakat.png',
                    ),
                    Text(
                      "Zakat",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: ColorConstant.colorWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'jadwal-sholat');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ic_menu_jadwal_sholat.png',
                    ),
                    Text(
                      "Jadwal Sholat",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: ColorConstant.colorWhite,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/ic_menu_video_kajian.png',
                  ),
                  Text(
                    "Video Kajian",
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      color: ColorConstant.colorWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget cardInspiration() {
      return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Inspirasi",
                style: TextStyle(
                  fontFamily: "PoppinsSemiBold",
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Image.asset('assets/images/img_inspiration.png'),
            const SizedBox(
              height: 8,
            ),
            Image.asset('assets/images/img_inspiration.png'),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            cardMenus(),
            cardInspiration(),
          ],
        ),
      ),
    );
  }
}
