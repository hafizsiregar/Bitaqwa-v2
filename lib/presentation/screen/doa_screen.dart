import 'package:bitaqwa/presentation/widgets/card_doa.dart';
import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorPrimary,
        title: Text(
          'Doa-doa',
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
      body: Column(
        children: [
          Image.asset(
            'assets/images/bg_header_doa.png',
          ),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 24,
              crossAxisCount: 3,
              children: const [
                CardDoa(
                  image: 'assets/images/ic_doa_pagi_malam.png',
                  title: "Pagi & Malam",
                ),
                CardDoa(
                  image: 'assets/images/ic_doa_rumah.png',
                  title: "Rumah",
                ),
                CardDoa(
                  image: 'assets/images/ic_doa_makanan_minuman.png',
                  title: "Makanan & Minuman",
                ),
                CardDoa(
                  image: 'assets/images/ic_doa_perjalanan.png',
                  title: "Perjalanan",
                ),
                CardDoa(
                  image: 'assets/images/ic_doa_sholat.png',
                  title: "Sholat",
                ),
                CardDoa(
                  image: 'assets/images/ic_doa_etika_baik.png',
                  title: "Etika Baik",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
