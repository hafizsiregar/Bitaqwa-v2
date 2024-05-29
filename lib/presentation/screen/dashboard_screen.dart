import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
    tz.initializeTimeZones();
    _updatePrayerTimes();
  }

  Future<void> _updatePrayerTimes() async {
    if (await _requestLocationPermission()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks.first;

        final myCoordinates =
            Coordinates(position.latitude, position.longitude);
        final location =
            tz.getLocation('Asia/Jakarta'); // Ensure correct time zone
        DateTime date = tz.TZDateTime.from(DateTime.now(), location);

        final params = CalculationMethod.karachi();
        params.madhab = Madhab.shafi;

        final prayerTimes = PrayerTimes(
          coordinates: myCoordinates,
          date: date,
          calculationParameters: params,
          precision: true,
        );

        final now = tz.TZDateTime.from(DateTime.now(), location);

        // Find the next prayer time
        String nextPrayer = prayerTimes.nextPrayer();
        DateTime? nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);

        setState(() {
          _location = "${place.subAdministrativeArea}, ${place.locality}";
          _prayerName = nextPrayer;
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
    } else {
      setState(() {
        _location = "Lokasi tidak tersedia";
        _prayerName = "Error";
        _prayerTime = "Error";
      });
    }
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
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
                  color: Colors.white,
                ),
                child: const Text(
                  "Assalamualaikum Fulan",
                  style: TextStyle(
                    color: Colors.black,
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
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'PoppinsMedium',
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _prayerTime,
              style: const TextStyle(
                color: Colors.black,
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
                const Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  _location,
                  style: const TextStyle(
                    color: Colors.black,
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
                    const Text(
                      "Doa-doa",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: Colors.white,
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
                    const Text(
                      "Zakat",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: Colors.white,
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
                    const Text(
                      "Jadwal Sholat",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: Colors.white,
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
                  Navigator.pushNamed(context, 'video-kajian');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ic_menu_video_kajian.png',
                    ),
                    const Text(
                      "Video Kajian",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
