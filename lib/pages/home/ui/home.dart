import 'package:expense/constants/category.dart';
import 'package:expense/constants/color.dart';
import 'package:expense/pages/home/controller/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add.dart';

class DotHome extends StatefulWidget {
  @override
  _DotHomeState createState() => _DotHomeState();
}

class _DotHomeState extends State<DotHome> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  HomeController homeController = HomeController();
  Map<String, dynamic> data = {
    "sum_today": 0,
    "sum_month": 0,
    "cat": [],
    "today": [],
    "yesterday": [],
  };

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    homeController.reloadDashboard().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo, User !",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Jangan lupa catat keuanganmu setiap hari!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF828282),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengeluaranmu hari ini",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rp. ${numberFormat.format(data['sum_today'])}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.teal,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengeluaranmu bulan ini",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rp. ${numberFormat.format(data['sum_month'])}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Pengeluaran berdasarkan kategori",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: (data['cat'] as List).map((e) {
                  return Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 0,
                      top: 15,
                      bottom: 20,
                    ),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300.withOpacity(0.6),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.grey.shade500.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryList.renderCategoryIcon(
                          e['key'],
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          CategoryList.items[e['key']]['label'],
                          style: TextStyle(
                            color: Color(0xFF828282),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Rp. ${numberFormat.format(e['nominal'])}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hari Ini",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: (data['today'] as List).map((e) {
                        return Container(
                          padding: EdgeInsets.all(13),
                          margin: EdgeInsets.only(top: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300.withOpacity(0.6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.grey.shade500.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CategoryList.renderCategoryIcon(
                                e['jenisPengeluaran'],
                                size: 40,
                                withBackground: false,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(e['namaPengeluaran']),
                              Expanded(
                                child: Container(),
                              ),
                              Text("Rp. ${numberFormat.format(e['nominal'])}"),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kemarin",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: (data['yesterday'] as List).map((e) {
                        return Container(
                          padding: EdgeInsets.all(13),
                          margin: EdgeInsets.only(top: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300.withOpacity(0.6),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.grey.shade500.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CategoryList.renderCategoryIcon(
                                e['jenisPengeluaran'],
                                size: 40,
                                withBackground: false,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(e['namaPengeluaran']),
                              Expanded(
                                child: Container(),
                              ),
                              Text("Rp. ${numberFormat.format(e['nominal'])}"),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddExpenses();
            }),
          );
          reload();
        },
        tooltip: 'Add Expense',
        child: Icon(Icons.add),
      ),
    );
  }
}
