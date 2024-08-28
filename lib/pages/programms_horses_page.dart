import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/pages/frequencies_horses_page.dart';

class ProgrammsHorsesPage extends StatefulWidget {
  const ProgrammsHorsesPage({super.key});

  @override
  State<ProgrammsHorsesPage> createState() => _ProgrammsHorsesPageState();
}

class _ProgrammsHorsesPageState extends State<ProgrammsHorsesPage> {
  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/frequencies_horses.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["programms"];
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
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Sans('Frequenzwelt für Pferde', 18, AppColors.white),
              background: Image.asset(
                'assets/images/horse-dark.png',
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
                      side:
                          const BorderSide(color: AppColors.primary, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrequenciesHorsesPage(
                          frequencies: _items[index]['frequencies'],
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    _items[index]["name"],
                    18,
                    AppColors.primary,
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
