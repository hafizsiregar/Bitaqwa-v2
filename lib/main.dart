import 'package:bitaqwa/presentation/screen/dashboard_screen.dart';
import 'package:bitaqwa/presentation/screen/doa_screen.dart';
import 'package:bitaqwa/presentation/screen/jadwal_sholat_screen.dart';
import 'package:bitaqwa/presentation/screen/video_kajian_screen.dart';
import 'package:bitaqwa/presentation/screen/zakat_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Tambahkan ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // Inisialisasi locale untuk Indonesia
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitaqwa App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const DashboardScreen(),
        'doa': (context) => const DoaScreen(),
        'zakat': (context) => const ZakatScreen(),
        'jadwal-sholat': (context) => const JadwalSholatScreen(),
        'video-kajian': (context) => const VideoKajianScreen(),
      },
    );
  }
}
