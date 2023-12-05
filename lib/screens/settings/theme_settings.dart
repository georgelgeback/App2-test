import 'package:flutter/material.dart';
import 'package:fsek_mobile/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/services/abstract.service.dart';
import 'package:fsek_mobile/services/service_locator.dart';
import 'package:fsek_mobile/services/theme.service.dart';
import 'package:fsek_mobile/themes.dart';

class ThemeSettingsPage extends StatefulWidget {
  ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  ThemeSettingsState createState() => ThemeSettingsState();
}

class ThemeSettingsState<ThemeSettingsPage> extends State {
  ThemeMode? _themeMode;

  void initState() {
    super.initState();
  }

  void _setTheme(BuildContext context, ThemeMode? themeMode) {
    setState(
      () {
        this._themeMode = themeMode!;
        FsekMobileApp.of(context)!.setTheme(themeMode);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.theme),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>( //TODO: Add localisation to this text
            title: Text("Mörkt läge", style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color)),
            value: ThemeMode.dark,
            groupValue: _themeMode,
            onChanged: (value) => _setTheme(context, value),
          ),
          RadioListTile<ThemeMode>(
            title: Text("Ljust läge", style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color)),
            value: ThemeMode.light,
            groupValue: _themeMode,
            onChanged: (value) => _setTheme(context, value),
          ),
        ],
      ),
    );
  }
}