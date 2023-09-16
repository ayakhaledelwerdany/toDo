import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization.dart';
import '../ButtomSheetTheme.dart';
import '../buttomSheetLang.dart';
import '../provider/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTap extends StatelessWidget {
  const SettingsTap({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.lang,
            style: TextStyle(color: provider.changeFontColor()),
          ),
          InkWell(
            onTap: () {
              showBottomSheetLanguage(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: provider.changeFontColor())),
              child: Text(
                provider.language == "en" ? "English" : "Arabic",
                style: TextStyle(color: provider.changeFontColor()),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.them,
            style: TextStyle(color: provider.changeFontColor()),
          ),
          InkWell(
            onTap: () {
              showBottomSheetTheme(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: provider.changeFontColor())),
              child: Text(
                provider.themeMode == ThemeMode.light ? "Light" : "Dark",
                style: TextStyle(color: provider.changeFontColor()),
              ),
            ),
          )
        ],
      ),
    );
  }

  showBottomSheetLanguage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ButtomSheetLang();
      },
    );
  }

  showBottomSheetTheme(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ButtomSheetTheme();
      },
    );
  }
}
