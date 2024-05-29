import 'package:bitaqwa/presentation/screen/detail_doa_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitaqwa/utils/color_constant.dart';

class DoaListScreen extends StatelessWidget {
  final String category;

  const DoaListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> doaList = getDoaList(category);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: ColorConstant.colorPrimary,
        title: Text(
          category,
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
      body: ListView.builder(
        itemCount: doaList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: ColorConstant.colorWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: ListTile(
                leading: Image.asset(doaList[index]['image']!),
                title: Text(
                  doaList[index]['title']!,
                  style: const TextStyle(fontFamily: "PoppinsMedium"),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailDoaScreen(
                        title: doaList[index]['title']!,
                        arabicText: doaList[index]['arabicText']!,
                        translation: doaList[index]['translation']!,
                        reference: doaList[index]['reference']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, String>> getDoaList(String category) {
    switch (category) {
      case "Makanan & Minuman":
        return [
          {
            'image': 'assets/images/ic_doa_makanan_minuman.png',
            'title': 'Do’a Sebelum Makan',
            'arabicText': 'بِسْمِ اللَّهِ',
            'translation': 'Dengan menyebut nama Allah',
            'reference': 'Hadist Riwayat Abu Dawud dan At-Tirmidzi'
          },
          {
            'image': 'assets/images/ic_doa_makanan_minuman.png',
            'title': 'Do’a Setelah Makan',
            'arabicText':
                'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
            'translation':
                'Segala puji bagi Allah yang telah memberiku makanan ini dan rezeki ini dengan tanpa daya dan kekuatan dariku',
            'reference': 'Hadist Riwayat Abu Dawud, At-Tirmidzi, dan Ibnu Majah'
          },
          {
            'image': 'assets/images/ic_doa_makanan_minuman.png',
            'title': 'Do’a Orang Yang Memberi Minum',
            'arabicText':
                'اللَّهُمَّ أَطْعِمْ مَنْ أَطْعَمَنِي، وَاسْقِ مَنْ سَقَانِي',
            'translation':
                'Ya Allah, berilah makan orang yang memberi makan kepadaku dan berilah minum orang yang memberi minum kepadaku',
            'reference': 'HR. Muslim'
          },
          {
            'image': 'assets/images/ic_doa_makanan_minuman.png',
            'title': 'Do’a Berbuka Di Rumah Orang Lain',
            'arabicText':
                'أَفْطَرَ عِنْدَكُمُ الصَّائِمُونَ، وَأَكَلَ طَعَامَكُمُ الأَبْرَارُ، وَصَلَّتْ عَلَيْكُمُ الْمَلاَئِكَةُ',
            'translation':
                'Semoga orang-orang yang berpuasa berbuka di tempat kalian, dan semoga orang-orang baik makan makanan kalian, dan semoga para malaikat mendoakan kalian',
            'reference': 'HR. Abu Dawud'
          },
          {
            'image': 'assets/images/ic_doa_makanan_minuman.png',
            'title': 'Do’a Berbuka Puasa',
            'arabicText':
                'ذَهَبَ الظَّمَأُ، وَابْتَلَّتِ الْعُرُوقُ، وَثَبَتَ الأَجْرُ إِنْ شَاءَ اللَّهُ',
            'translation':
                'Telah hilang dahaga, urat-urat telah basah, dan telah ditetapkan pahala insya Allah',
            'reference': 'HR. Abu Dawud'
          },
        ];
      case "Pagi & Malam":
        return [
          {
            'image': 'assets/images/ic_doa_pagi_malam.png',
            'title': 'Do’a Sebelum Tidur',
            'arabicText': 'اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
            'translation': 'Ya Allah, dengan namaMu aku mati dan aku hidup.',
            'reference': 'Hadist Riwayat Bukhori'
          },
          {
            'image': 'assets/images/ic_doa_pagi_malam.png',
            'title': 'Do’a Bangun Tdiur',
            'arabicText':
                'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
            'translation':
                'Segala puji bagi Allah yang menghidupkanku dan mematikanku dan kepadaNya lah kita dikembalikan.',
            'reference': 'Hadist Riwayat Bukhori'
          },
          {
            'image': 'assets/images/ic_doa_pagi_malam.png',
            'title': 'Doa Apabila Ada Yang Menakutkan Dalam Tidur',
            'arabicText':
                'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ، وَشَرِّ عِبَادِهِ، وَمِنْ هَمَزَاتِ الشَّيَاطِينِ وَأَنْ يَحْضُرُونِ',
            'translation':
                'Aku berlindung dengan kalimat Allah yang sempurna dari kemarahan, siksaan dan kejahatan hamba-hamba-Nya dan dari godaan setan serta jangan sampai setan mendatangiku',
            'reference': 'Hadist Riwayat Abu Dawud dan Shohih At-Tirmidzi'
          },
        ];
      // Tambahkan kategori lain di sini
      default:
        return [];
    }
  }
}
