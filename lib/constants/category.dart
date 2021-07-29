import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryList {
  static Map<String, dynamic> items = {
    "makanan": {
      "label": "Makanan",
      "asset": "assets/category/makanan.svg",
      "color": Color(0xFFF2C94C),
    },
    "internet": {
      "label": "Internet",
      "asset": "assets/category/internet.svg",
      "color": Color(0xFF56CCF2),
    },
    "edukasi": {
      "label": "Edukasi",
      "asset": "assets/category/edukasi.svg",
      "color": Color(0xFFF2994A),
    },
    "hadiah": {
      "label": "Hadiah",
      "asset": "assets/category/hadiah.svg",
      "color": Color(0xFFEB5757),
    },
    "transport": {
      "label": "Transport",
      "asset": "assets/category/transport.svg",
      "color": Color(0xFF9B51E0),
    },
    "belanja": {
      "label": "Belanja",
      "asset": "assets/category/belanja.svg",
      "color": Color(0xFF27AE60),
    },
    "alatrumah": {
      "label": "Alat Rumah",
      "asset": "assets/category/alatrumah.svg",
      "color": Color(0xFFBB6BD9),
    },
    "olahraga": {
      "label": "Olahraga",
      "asset": "assets/category/olahraga.svg",
      "color": Color(0xFF2D9CDB),
    },
    "hiburan": {
      "label": "Hiburan",
      "asset": "assets/category/hiburan.svg",
      "color": Color(0xFF2F80ED),
    },
  };

  static Widget renderCategoryIcon(
    String key, {
    double size: 50,
    double iconSize: 20,
    bool withBackground: true,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: withBackground ? items[key]['color'] : Colors.transparent,
        borderRadius: BorderRadius.circular(size),
      ),
      child: Center(
        child: SvgPicture.asset(
          items[key]['asset'],
          color: withBackground ? Colors.white : items[key]['color'],
          width: iconSize,
        ),
      ),
    );
  }

  static Widget renderCategory(
      String key, Function(String key, String label) onTap) {
    return InkWell(
      onTap: () {
        onTap(key, items[key]['label']);
      },
      child: Container(
        child: Column(
          children: [
            renderCategoryIcon(key),
            SizedBox(
              height: 10,
            ),
            Text(
              items[key]['label'],
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
