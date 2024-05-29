import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:bitaqwa/presentation/widgets/time.dart';
import 'package:bitaqwa/utils/color_constant.dart';

class JadwalSholatScreen extends StatefulWidget {
  const JadwalSholatScreen({super.key});

  @override
  State<JadwalSholatScreen> createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  PrayerTimes? _prayerTimes;
  String? _locationName; // Untuk menyimpan nama lokasi

  // Fungsi untuk mendapatkan nama lokasi dari koordinat
  Future<void> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;
      setState(() {
        // Contoh: Menggabungkan nama kecamatan dan kota
        _locationName = "${place.subAdministrativeArea}, ${place.locality}";
      });
    } catch (e) {
      print("Failed to get placemark: $e");
      setState(() {
        _locationName = "Lokasi tidak dikenal";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _determinePositionAndPrayerTimes();
  }

  Future<void> _determinePositionAndPrayerTimes() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        _calculatePrayerTimes(position);
      } catch (e) {
        // Handle jika tidak bisa mendapatkan posisi
        print('Error: $e');
      }
    } else {
      // Mungkin ingin menampilkan dialog atau snackbar bahwa izin diperlukan
      print('Location permission not granted');
    }
  }

  void _calculatePrayerTimes(Position position) {
    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.karachi();
    params.madhab = Madhab.hanafi;

    final location = tz.getLocation('Asia/Jakarta');
    final date = tz.TZDateTime.from(DateTime.now(), location);

    _prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
    );
    _getLocationName(position.latitude, position.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorPrimary,
        title: Text(
          'Jadwal Sholat',
          style: TextStyle(
            color: ColorConstant.colorWhite,
            fontFamily: "PoppinsMedium",
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorConstant.colorWhite,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.blue[50],
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/bg_header_jadwal_sholat.png',
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          DateFormat('EEEE, d MMMM', 'id_ID')
                              .format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "PoppinsSemiBold",
                            color: ColorConstant.colorWhite,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
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
                            _locationName ?? "Mengambil lokasi...",
                            style: TextStyle(
                              color: ColorConstant.colorWhite,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstant.colorWhite,
                        ),
                        child: Column(
                          children: [
                            Time(
                              pray: "Subuh",
                              time: _prayerTimes!.asr != null
                                  ? DateFormat.jm().format(_prayerTimes!.fajr!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color(0xffC5E6DB),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Time(
                              pray: "Terbit",
                              time: _prayerTimes!.sunrise != null
                                  ? DateFormat.jm()
                                      .format(_prayerTimes!.sunrise!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color(0xffC5E6DB),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Time(
                              pray: "Dzuhur",
                              time: _prayerTimes!.dhuhr != null
                                  ? DateFormat.jm().format(_prayerTimes!.dhuhr!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color(0xffC5E6DB),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Time(
                              pray: "Ashar",
                              time: _prayerTimes!.asr != null
                                  ? DateFormat.jm().format(_prayerTimes!.asr!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color(0xffC5E6DB),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Time(
                              pray: "Maghrib",
                              time: _prayerTimes!.maghrib != null
                                  ? DateFormat.jm()
                                      .format(_prayerTimes!.maghrib!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color(0xffC5E6DB),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Time(
                              pray: "Isya",
                              time: _prayerTimes!.isha != null
                                  ? DateFormat.jm().format(_prayerTimes!.isha!)
                                  : "N/A",
                              image: "assets/images/img_clock.png",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
