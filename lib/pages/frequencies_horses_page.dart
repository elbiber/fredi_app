import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/set_actual_frequency_modal.dart';

class FrequenciesHorsesPage extends StatefulWidget {
  const FrequenciesHorsesPage({super.key});

  @override
  State<FrequenciesHorsesPage> createState() => _FrequenciesHorsesPageState();
}

class _FrequenciesHorsesPageState extends State<FrequenciesHorsesPage> {
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
                        builder: (context) => SetActualFreq(
                          selectedFrequency: 'Pferd Frequenz ${1 + index}',
                          audioAsset: 'audio/frequency_001.mp3',
                          packageColor: AppColors.primary,
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    'Pferd Frequenz ${1 + index}',
                    18,
                    AppColors.primary,
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
