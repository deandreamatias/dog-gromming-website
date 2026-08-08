import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/opening_hours.dart';
import 'package:dog_gromming_website/domain/use_cases/get_place_details_use_case.dart';
import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/utils/opening_hours_formatter.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/social_networks.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WhenCard extends StatefulWidget {
  const WhenCard({super.key});

  @override
  State<WhenCard> createState() => _WhenCardState();
}

class _WhenCardState extends State<WhenCard> {
  static const List<String> _weekdayKeys = <String>[
    'home.when.sunday',
    'home.when.monday',
    'home.when.tuesday',
    'home.when.wednesday',
    'home.when.thursday',
    'home.when.friday',
    'home.when.saturday',
  ];

  final OpeningHoursFormatter _formatter = const OpeningHoursFormatter();

  OpeningHours? _openingHours;
  bool _loading = true;
  bool _fetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_fetched) return;
    _fetched = true;
    _loadOpeningHours();
  }

  Future<void> _loadOpeningHours() async {
    final useCase = getIt<GetPlaceDetailsUseCase>();
    final languageCode = context.locale.languageCode;
    final result = await useCase(languageCode: languageCode);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _openingHours = result.fold((_) => null, (hours) => hours);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SelectionArea(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8,
                    children: [
                      TitleLText('home.when.title'.tr()),
                      ..._scheduleWidgets(context),
                    ],
                  ),
                ),
              ),
            ),
            BoxSpacer.v8(),
            Expanded(
              flex: 2,
              child: SelectionArea(
                child: Column(
                  spacing: 8,
                  children: [
                    TitleLText('home.contact.title'.tr()),
                    BodyMText('home.contact.phone'.tr(args: [Constants.phone])),
                    BodyMText('home.contact.email'.tr(args: [Constants.email])),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BodyMText('home.contact.social_networks'.tr()),
                        const SocialNetworks(isCenter: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _scheduleWidgets(BuildContext context) {
    final hours = _openingHours;
    if (_loading || hours == null) {
      return <Widget>[
        BodyMText('home.when.schedule_1'.tr(), textAlign: TextAlign.center),
      ];
    }

    final weekdayLabels = <String>[
      for (final key in _weekdayKeys) context.tr(key),
    ];

    final widgets = <Widget>[];
    final status = _statusWidget(context, hours);
    if (status != null) {
      widgets.add(
        BodyMText(
          status.label,
          textAlign: TextAlign.center,
          color: status.color,
        ),
      );
    }

    final scheduleLines = _formatter.schedule(hours, weekdayLabels);
    if (scheduleLines.isEmpty) {
      widgets.add(
        BodyMText('home.when.schedule_1'.tr(), textAlign: TextAlign.center),
      );
    } else {
      widgets.addAll(
        scheduleLines.map(
          (line) => BodyMText(line, textAlign: TextAlign.center),
        ),
      );
    }

    final closedDayLines = _formatter.closedDayLines(
      hours,
      weekdayLabels,
      _formatDateLabel,
    );
    final errorColor = Theme.of(context).colorScheme.error;
    widgets.addAll(
      closedDayLines.map(
        (line) =>
            BodyMText(line, textAlign: TextAlign.center, color: errorColor),
      ),
    );

    return widgets;
  }

  ({String label, Color color})? _statusWidget(
    BuildContext context,
    OpeningHours hours,
  ) {
    final errorColor = Theme.of(context).colorScheme.error;
    switch (hours.businessStatus) {
      case BusinessStatus.closedTemporarily:
        return (label: 'home.when.closed_temporarily'.tr(), color: errorColor);
      case BusinessStatus.closedPermanently:
        return (label: 'home.when.closed_permanently'.tr(), color: errorColor);
      case BusinessStatus.operational:
        break;
    }

    if (hours.isOpenNow) {
      return (label: 'home.when.open'.tr(), color: AppColors.secondary);
    }
    return (label: 'home.when.closed'.tr(), color: errorColor);
  }

  String _formatDateLabel(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return 'home.when.closed_on'.tr(args: <String>['$date.year-$month-$day']);
  }
}
