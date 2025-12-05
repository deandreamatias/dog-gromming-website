import 'package:dog_gromming_website/env/constants.dart';
import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/utils/seo_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/loading_circle.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

final _modifiedPrivacy = DateTime(2023, 09, 17);

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SeoUtil.updatePrivacyPolicyPageSeo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: TitleLText('privacy_policy.title'.tr()),
      ),
      body: Padding(
        padding: Insets.a20,
        child: FutureBuilder(
          future: rootBundle.loadString(Constants.privacyPolicy),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SelectionArea(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HtmlWidget(
                          snapshot.requireData,
                          onLoadingBuilder:
                              (context, element, loadingProgress) =>
                                  const LoadingCircle(),
                        ),
                        BoxSpacer.v16(),
                        BodyMText(
                          'privacy_policy.modify_date'.tr(
                            args: [
                              _modifiedPrivacy.toLocal().toString().replaceAll(
                                '00:00:00.000',
                                '',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const LoadingCircle();
          },
        ),
      ),
    );
  }
}
