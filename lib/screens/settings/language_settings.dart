import 'package:flutter/material.dart';
import 'package:fsek_mobile/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/services/abstract.service.dart';

class LanguageSettingsPage extends StatefulWidget {
  LanguageSettingsPage({Key? key}) : super(key: key);

  @override
  LanguageSettingsState createState() => LanguageSettingsState();
}

class LanguageSettingsState<LanguageSettingsPage> extends State {
  String? _locale;

  void initState() {
    super.initState();
  }

  void _setLocale(BuildContext context, String? locale) {
    setState(
      () {
        this._locale = locale!;
        FsekMobileApp.of(context)!.setLocale(locale);
        if (_locale == "en") {
          AbstractService.updateApiUrl(false);
        } else {
          AbstractService.updateApiUrl(true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _locale = Localizations.localeOf(context).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: Text("Svenska", style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color)),
            value: 'sv',
            groupValue: _locale,
            onChanged: (value) => _setLocale(context, value),
          ),
          RadioListTile<String>(
            title: Text("English", style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color)),
            value: 'en',
            groupValue: _locale,
            onChanged: (value) => _setLocale(context, value),
          ),
        ],
      ),
    );
  }
}

/*
Column(
          children: [
            InkWell(
              onTap: () {
                FsekMobileApp.of(context)!.setLocale('sv');
              },
              child: Card(
                child: Text("Byt språk lol"),
              ),
            ),
          ],*/