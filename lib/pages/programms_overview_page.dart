import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/pages/frequencies_overview_page.dart';

class ProgrammsOverviewPage extends StatefulWidget {
  final String titel, jsonFile, titelImage, languageCode;
  final Color packageColor;

  const ProgrammsOverviewPage(
      {super.key,
      required this.jsonFile,
      required this.titel,
      required this.titelImage,
      required this.packageColor,
      required this.languageCode});

  @override
  State<ProgrammsOverviewPage> createState() => _ProgrammsOverviewPageState();
}

class _ProgrammsOverviewPageState extends State<ProgrammsOverviewPage> {
  List _items = [];
  String _packageID = '';

  Future<void> readJson() async {
    final String response = await rootBundle
        .loadString('assets/data/${widget.languageCode}/${widget.jsonFile}');
    final data = await json.decode(response);
    setState(() {
      _packageID = data["package_id"];
      _items = data["programms"];
      debugPrint(_packageID);
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: widget.packageColor,
            foregroundColor: AppColors.white,
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Sans(widget.titel, 18, AppColors.white),
              background: Image.asset(
                'assets/images/${widget.titelImage}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: widget.packageColor, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrequenciesOverviewPage(
                          frequencies: _items[index]['frequencies'],
                          titel: widget.titel,
                          titelImage: widget.titelImage,
                          packageID: _packageID,
                          packageColor: widget.packageColor,
                          programName: _items[index]['program_name'],
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    _items[index]["name"],
                    18,
                    widget.packageColor,
                  ),
                ),
              );
            }, childCount: _items.length),
          )
        ],
      ),
    );
  }
}
