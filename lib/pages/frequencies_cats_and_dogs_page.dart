import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/set_actual_frequency_modal.dart';

class FrequenciesCatsAndDogsPage extends StatefulWidget {
  const FrequenciesCatsAndDogsPage({super.key});

  @override
  State<FrequenciesCatsAndDogsPage> createState() =>
      _FrequenciesCatsAndDogsPageState();
}

class _FrequenciesCatsAndDogsPageState
    extends State<FrequenciesCatsAndDogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Sans(
                  'Frequenzwelt für Hunde und Katzen', 18, AppColors.white),
              background: Image.asset(
                'assets/images/cat-and-dog-dark.png',
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
                      side: const BorderSide(color: AppColors.green, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetActualFreq(
                          selectedFrequency:
                              'Hund und Katze Frequenz ${1 + index}',
                          audioAsset: 'audio/frequency_001.mp3',
                          loadingColor: AppColors.green,
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    'Hund und Katze Frequenz ${1 + index}',
                    18,
                    AppColors.green,
                  ),
                ),
              );
            }, childCount: 26),
          )
        ],
      ),
    );
  }
}
