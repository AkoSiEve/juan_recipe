// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List catalogdata = [];
  @override
  void initState() {
    // TODO: implement initState
    this.loadData();
    super.initState();
  }

  Future<void> loadData() async {
    var data = await rootBundle.loadString("assets/categories.json");
    final data1 = await json.decode(data);
    print(data1['categories']['data']);
    setState(() {
      catalogdata = data1['categories']['data'];
    });
    // return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: catalogdata.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(catalogdata[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
