import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';

class CardDoa extends StatelessWidget {
  final String image;
  final String title;
  const CardDoa({required this.image, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.colorWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 3.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "PoopinsMedium"),
          ),
        ],
      ),
    );
  }
}
