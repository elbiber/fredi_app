import 'package:flutter/material.dart';
import 'package:fredi_app/components/app_colors.dart';
import 'package:fredi_app/components/font_components.dart';
import 'package:fredi_app/modals/set_actual_frequency_modal.dart';

class FrequenciesOverviewPage extends StatefulWidget {
  final String titel, titelImage, packageID;
  final List frequencies;
  final Color packageColor;

  const FrequenciesOverviewPage(
      {super.key,
      required this.frequencies,
      required this.titel,
      required this.titelImage,
      required this.packageID,
      required this.packageColor});

  @override
  State<FrequenciesOverviewPage> createState() =>
      _FrequenciesOverviewPageState();
}

class _FrequenciesOverviewPageState extends State<FrequenciesOverviewPage> {
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
                        builder: (context) => SetActualFreq(
                          selectedFrequency: widget.frequencies[index]['name'],
                          audioAsset:
                              'audio/${widget.packageID}/${widget.frequencies[index]["audio_file"]}',
                          packageColor: widget.packageColor,
                        ),
                      ),
                    );
                  },
                  title: SansCentered(
                    widget.frequencies[index]['name'],
                    18,
                    widget.packageColor,
                  ),
                ),
              );
            }, childCount: widget.frequencies.length),
          )
        ],
      ),
    );
  }
}
