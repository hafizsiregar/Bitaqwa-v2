import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:bitaqwa/presentation/widgets/time.dart';
import 'package:bitaqwa/utils/color_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class JadwalSholatScreen extends StatefulWidget {
  const JadwalSholatScreen({super.key});

  @override
  State<JadwalSholatScreen> createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  List<dynamic>? _jadwalSholat;
  String? _locationName;
  bool _isLoading = true;

  Future<List<dynamic>> fetchJadwalSholat(
      String city, String month, String year) async {
    final url =
        'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/$city/$year/$month.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load jadwal sholat');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocationAndJadwalSholat();
  }

  Future<void> _fetchLocationAndJadwalSholat() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks.first;

        // Gunakan kota yang sesuai dari daftar kota API
        String city = "bogor"; // pastikan kota ini ada di daftar kota API
        String month = DateFormat('MM').format(DateTime.now());
        String year = DateFormat('yyyy').format(DateTime.now());

        List<dynamic> jadwalSholat = await fetchJadwalSholat(city, month, year);

        setState(() {
          _jadwalSholat = jadwalSholat;
          _locationName = "${place.subAdministrativeArea}, ${place.locality}";
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print("Error fetching location or jadwal sholat: $e");
      }
    } else {
      print('Location permission not granted');
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _jadwalSholat == null
              ? const Center(child: Text("Failed to load jadwal sholat"))
              : Container(
                  color: Colors.blue[50],
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg_header_jadwal_sholat.png',
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 48),
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
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 14,
                                color: ColorConstant.colorPrimary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _locationName ?? "Mengambil lokasi...",
                                style: TextStyle(
                                  color: ColorConstant.colorWhite,
                                  fontFamily: 'PoppinsRegular',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 48),
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
                                  time: _jadwalSholat![0]['shubuh'] ?? "N/A",
                                  image: "assets/images/img_clock.png",
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: const Color(0xffC5E6DB),
                                ),
                                const SizedBox(height: 16),
                                Time(
                                  pray: "Dzuhur",
                                  time: _jadwalSholat![0]['dzuhur'] ?? "N/A",
                                  image: "assets/images/img_clock.png",
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: const Color(0xffC5E6DB),
                                ),
                                const SizedBox(height: 16),
                                Time(
                                  pray: "Ashar",
                                  time: _jadwalSholat![0]['ashr'] ?? "N/A",
                                  image: "assets/images/img_clock.png",
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: const Color(0xffC5E6DB),
                                ),
                                const SizedBox(height: 16),
                                Time(
                                  pray: "Maghrib",
                                  time: _jadwalSholat![0]['magrib'] ?? "N/A",
                                  image: "assets/images/img_clock.png",
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  color: const Color(0xffC5E6DB),
                                ),
                                const SizedBox(height: 16),
                                Time(
                                  pray: "Isya",
                                  time: _jadwalSholat![0]['isya'] ?? "N/A",
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
