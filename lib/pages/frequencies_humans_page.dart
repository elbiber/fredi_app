import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/set_actual_frequency_modal.dart';

class FrequenciesHumansPage extends StatefulWidget {
  const FrequenciesHumansPage({super.key});

  @override
  State<FrequenciesHumansPage> createState() => _FrequenciesHumansPageState();
}

class _FrequenciesHumansPageState extends State<FrequenciesHumansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.complementary,
            foregroundColor: Colors.white,
            stretch: true,
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title:
                  const Sans('Frequenzwelt für Menschen', 18, AppColors.white),
              background: Image.asset(
                'assets/images/human-full-dark.png',
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
                      side: const BorderSide(
                          color: AppColors.complementary, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: AppColors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetActualFreq(
                          selectedFrequency: 'Mensch Frequenz ${1 + index}',
                          audioAsset: 'audio/frequency_001.mp3',
                          packageColor: AppColors.complementary,
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    'Mensch Frequenz ${1 + index}',
                    18,
                    AppColors.complementary,
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
