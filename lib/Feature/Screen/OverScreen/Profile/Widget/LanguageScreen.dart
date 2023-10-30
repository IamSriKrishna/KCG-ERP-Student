import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/LanguageContoller.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:kcgerp/l10n/LanguageController.dart';

class LanguagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RobotoBoldFont(text: S.current.language),
      ),
      body: GetBuilder<LanguageController>(
        builder: (languageController) {
          return Column(
            children: [
              Expanded(
                child: SafeArea(
                  top: false,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: index,
                        groupValue: languageController.selectedLanguageIndex.value,
                        dense: true,
                        onChanged: (value) {
                          languageController.changeLanguage(index);
                        },
                        title: RobotoBoldFont(
                          text:languages[index],
                        ),
                        subtitle: RobotoRegularFont(
                          text:subLanguage[index],
                        ),
                      );
                    },
                    itemCount: languages.length,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
