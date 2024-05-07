import 'package:bitaqwa/utils/color_constant.dart';
import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  final String pray;
  final String time;
  final String image;
  const Time({
    required this.pray,
    required this.time,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          pray,
          style: TextStyle(
            color: ColorConstant.colorText,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        const Spacer(),
        Text(
          time,
          style: TextStyle(
            color: ColorConstant.colorText,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Image.asset(image),
      ],
    );
  }
}
