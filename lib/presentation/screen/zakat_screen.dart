import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  final MoneyMaskedTextController controllerRupiah = MoneyMaskedTextController(
    thousandSeparator: '.',
    precision: 0,
    decimalSeparator: '',
  );
  double totalHarta = 0;
  double zakatDikeluarkan = 0;
  final double minimumHarta = 85000000;

  String formattedTotalHarta = '';
  String formattedZakatDikeluarkan = '';

  void hitungZakat() {
    String cleanValue = controllerRupiah.text.replaceAll('.', '');
    double inputValue = double.tryParse(cleanValue) ?? 0;

    if (inputValue >= minimumHarta) {
      setState(() {
        totalHarta = inputValue;
        zakatDikeluarkan = (inputValue * 2.5) / 100;
      });

      formattedTotalHarta = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
          .format(totalHarta);
      formattedZakatDikeluarkan =
          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
              .format(zakatDikeluarkan);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Peringatan'),
          content: const Text('Total belum mencapai Hisab (85gr)'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTotalHarta = controllerRupiah.text.replaceAll('.', ',');
    String formattedZakatDikeluarkan =
        zakatDikeluarkan.toStringAsFixed(0).replaceAll('.', ',');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.colorPrimary,
        title: Text(
          'Zakat',
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
      body: ListView(
        children: [
          Image.asset('assets/images/bg_header_zakat.png'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Harta",
                  style: TextStyle(
                    color: ColorConstant.colorPrimary,
                    fontSize: 14,
                    fontFamily: "PoppinsMedium",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controllerRupiah,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Total Harta',
                    labelStyle: TextStyle(
                      color: ColorConstant.colorText,
                      fontSize: 14,
                    ),
                    fillColor: ColorConstant.colorWhite,
                    filled: true,
                    prefixText: 'Rp. ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: ColorConstant.colorPrimary,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: ColorConstant.colorPrimary,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    hitungZakat();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    minimumSize: const Size(
                      double.infinity,
                      0,
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: ColorConstant.colorWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red[400],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Uang",
                      style: TextStyle(
                        color: ColorConstant.colorWhite,
                        fontFamily: "PoppinsMedium",
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Rp. $formattedTotalHarta",
                      style: TextStyle(
                        color: ColorConstant.colorWhite,
                        fontFamily: "PoppinsBold",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple[400],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Zakat Dikeluarkan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.colorWhite,
                        fontFamily: "PoppinsMedium",
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Rp. $formattedZakatDikeluarkan",
                      style: TextStyle(
                        color: ColorConstant.colorWhite,
                        fontFamily: "PoppinsBold",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
