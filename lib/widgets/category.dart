import 'package:expense/constants/category.dart';
import 'package:flutter/material.dart';

class CategoryChoice extends StatelessWidget {
  final Function(String key, String label) onTap;

  const CategoryChoice({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: 420,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Pilih Kategori",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            InkWell(
                              child: Icon(Icons.close),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 30),
                          children: CategoryList.items.keys.map((e) {
                            return CategoryList.renderCategory(e, (key, label) {
                              onTap(key, label);
                              Navigator.pop(context);
                            });
                          }).toList(),
                          crossAxisCount: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
