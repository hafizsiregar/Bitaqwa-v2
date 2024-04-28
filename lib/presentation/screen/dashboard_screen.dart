import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg_header_doa.png',
            ),
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
                  "Assalamualaikum Haura",
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
              "Dzuhur",
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
              "12:04",
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
                  "Kecamatan Jonggol",
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
              Column(
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
              const SizedBox(
                width: 12,
              ),
              Column(
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
              const SizedBox(
                width: 12,
              ),
              Column(
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
