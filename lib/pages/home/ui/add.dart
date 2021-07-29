import 'package:expense/constants/category.dart';
import 'package:expense/constants/color.dart';
import 'package:expense/pages/home/controller/add.dart';
import 'package:expense/widgets/category.dart';
import 'package:expense/widgets/moneyformat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final _formKey = GlobalKey<FormState>();

  DateTime tanggalPilih = DateTime.now();

  TextEditingController namaPengeluaran = TextEditingController();
  TextEditingController jenisPengeluaran = TextEditingController();
  TextEditingController tanggalPengeluaran = TextEditingController();
  MoneyMaskedTextController nominalPengeluaran = MoneyMaskedTextController();

  AddController addController = AddController();

  String currentJenis = "makanan";

  @override
  void initState() {
    super.initState();

    // TODO: edit data, gunakan key disini
    jenisPengeluaran.text = CategoryList.items[currentJenis]['label'];
  }

  @override
  Widget build(BuildContext context) {
    bool buttonEnabled = namaPengeluaran.text.length > 3 &&
        jenisPengeluaran.text.length > 3 &&
        tanggalPengeluaran.text.length > 3 &&
        nominalPengeluaran.text.length > 5;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Tambah Pengeluaran Baru",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  inputForm(
                    namaPengeluaran,
                    "Nama Pengeluaran",
                  ),
                  SizedBox(height: 20),
                  inputForm(
                    jenisPengeluaran,
                    'Jenis Pengeluaran',
                    prefix: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CategoryList.renderCategoryIcon(
                        currentJenis,
                        size: 30,
                        iconSize: 15,
                        withBackground: false,
                      ),
                    ),
                    suffix: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => CategoryChoice(
                              onTap: (key, label) {
                                jenisPengeluaran.text = label;
                                setState(() {
                                  currentJenis = key;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 18,
                          height: 18,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  inputForm(
                    tanggalPengeluaran,
                    "Tanggal Pengeluaran",
                    readonly: true,
                    suffix: InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          locale: LocaleType.id,
                          currentTime: tanggalPilih,
                          onConfirm: (val) {
                            initializeDateFormatting('id_ID').then((value) {
                              tanggalPengeluaran.text =
                                  DateFormat('EEEEE, dd MMMM yyyy').format(val);
                            });

                            setState(() {
                              tanggalPilih = val;
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(
                          'assets/datepicker.png',
                          width: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  inputForm(
                    nominalPengeluaran,
                    "Nominal",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: buttonEnabled
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    addController.insert(
                                      nama: namaPengeluaran.text,
                                      jenis: currentJenis,
                                      tanggal: tanggalPilih,
                                      nominal: nominalPengeluaran.numberValue,
                                    );
                                    // TODO: reload dashboard
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Sukses Menambah Data'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputForm(
    TextEditingController controller,
    String label, {
    Widget? suffix,
    Widget? prefix,
    bool readonly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Stack(
      children: [
        TextFormField(
          onChanged: (v) {
            setState(() {});
          },
          keyboardType: keyboardType,
          readOnly: readonly,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 18,
              right: 18,
              bottom: 18,
              left: prefix != null ? 50 : 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
                color: AppColor.border,
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[500]),
            hintText: label,
            fillColor: Colors.white70,
            isDense: false,
          ),
        ),
        if (prefix != null)
          Positioned(
            left: 0,
            top: 0,
            child: prefix,
          ),
        if (suffix != null)
          Positioned(
            right: 0,
            top: 0,
            child: suffix,
          )
      ],
    );
  }
}
