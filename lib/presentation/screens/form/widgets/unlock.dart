import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Unlock extends StatelessWidget {
  const Unlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 9, right: 30),
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 245, 232, 1),
        ),
        child: Container(
          height: 10,
          width: 10,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            'assets/images/svg/unlock.svg',
            colorFilter: const ColorFilter.mode(
              Color.fromRGBO(
                229,
                190,
                144,
                1,
              ),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
