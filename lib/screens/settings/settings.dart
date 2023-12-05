import 'package:flutter/material.dart';
import 'package:fsek_mobile/models/user/user.dart';
import 'package:fsek_mobile/services/service_locator.dart';
import 'package:fsek_mobile/services/user.service.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user;

  static List<int> years =
      List.generate(DateTime.now().year - 1960, (i) => DateTime.now().year - i);

  bool extraPref = false;
  bool changedSetting = false;

  @override
  void initState() {
    locator<UserService>().syncUser();
    locator<UserService>().getUser().then((value) {
      setState(() {
        user = value;
        extraPref = user!.food_custom != "";
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    Map<String, String> programs = {
      "Teknisk Fysik": t.physics,
      "Teknisk Matematik": t.mathematics,
      "Teknisk Nanovetenskap": t.nano,
      "Oklart": t.unknown,
    };
    Map<String, String> reverseProgramsMap = {
      t.physics: "Teknisk Fysik",
      t.mathematics: "Teknisk Matematik",
      t.nano: "Teknisk Nanovetenskap",
      t.unknown: "Oklart",
    };
    if (user == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(t.otherAccount),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).textTheme.titleLarge?.color,),
          body: Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onBackground)));
    }
    return WillPopScope(
      onWillPop: () async {
        if (changedSetting)
          await showDialog(context: context, builder: _saveOnClosePopup());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.otherAccount),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: GestureDetector(
                  onTap: () => _save(),
                  child: Text(
                    t.settingsSave,
                    style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleLarge?.color),
                  ),
                ),
              ),
            ),
          ],
        ), //Alot of the code here is duplicate. could be made much more compact
        // Now it is a bit less bad
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _makePadding([
                _makeTextField(
                  t.settingsFirstName + "*",
                  user!.firstname,
                  (input) => user!.firstname = input,
                ),
                _makeTextField(
                  t.settingsLastName + "*",
                  user!.lastname,
                  (input) => user!.lastname = input,
                ),
                _makeDropDown<String>(
                  t.settingsProgramme,
                  programs.values.toList(),
                  programs[user!.program],
                  (program) => user!.program = reverseProgramsMap[program],
                ),
                _makeDropDown<int>(
                  t.settingsStartYear,
                  years,
                  user!.start_year,
                  (year) => user!.start_year = year,
                ),
              ]),
              _makeGrayTextbox(t.settingsParagraph),
              _makePadding([
                _makeTextField(
                  "LUCAT-id",
                  user!.student_id,
                  (input) => user!.student_id = input,
                ),
                _makeTextField(t.settingsPhoneNumber, user!.phone,
                    (input) => user!.phone = input,
                    num: true),
                _makeCheckBox(
                  t.settingsShowPhoneNumber,
                  user!.display_phone,
                  (bool? change) => user!.display_phone = change,
                ),
                DropdownButton(
                  isExpanded: true,
                  hint: Text(t.settingsFoodPrefs),
                  onChanged: (_) {},
                  items: {
                    "vegetarian": t.vegetarian,
                    "vegan": t.vegan,
                    "pescetarian": t.pescetarian,
                    "milk": t.milk,
                    "gluten": t.gluten
                  }
                      .entries
                      .map((foodPref) => DropdownMenuItem(
                            value: foodPref.value,
                            child: _makeCheckBox(
                              foodPref.value,
                              user!.food_preferences!.contains(foodPref.key),
                              (bool? change) {
                                if (change!)
                                  user!.food_preferences!.add(foodPref.key);
                                else
                                  user!.food_preferences!.remove(foodPref.key);
                              },
                            ),
                          ))
                      .toList()
                    ..add(DropdownMenuItem(
                      value: t.settingsOther,
                      child: _makeCheckBox(t.settingsOther, extraPref,
                          (bool? change) => extraPref = change ?? false),
                    )),
                ),
                if (extraPref)
                  _makeTextField(t.settingsOtherFoodPrefs, user!.food_custom,
                      (input) => user!.food_custom = input),
                Text(
                  t.settingsFoodPrefsPrivacy,
                  style: TextStyle(color: Colors.grey[600]),
                )
              ]),
              _makeGrayTextbox(t.notifications),
              _makePadding([
                _makeCheckBox(
                    t.settingsNotificationsSignUp,
                    user!.notify_event_users,
                    (bool? change) => user!.notify_event_users = change),
                _makeCheckBox(
                    t.settingsNotificationsMessage,
                    user!.notify_messages,
                    (bool? change) => user!.notify_messages = change),
                _makeCheckBox(
                    t.settingsNotificationsSignUpClosing,
                    user!.notify_event_closing,
                    (bool? change) => user!.notify_event_closing = change),
                _makeCheckBox(
                    t.settingsNotificationsSignUpOpening,
                    user!.notify_event_open,
                    (bool? change) => user!.notify_event_open = change)
              ]),
              _makeGrayTextbox(t.settingsMemberSince + _makeTimestamp())
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeTextField(
      String displayText, String? fieldText, void Function(String?) modUser,
      {bool num = false}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(displayText, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium?.color)),
          TextField(
            controller: TextEditingController(text: fieldText,),
            decoration: InputDecoration(border: UnderlineInputBorder()),
            style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
            keyboardType: num ? TextInputType.number : null,
            onChanged: (change) {
              modUser(change);
              changedSetting = true;
            },
          )
        ],
      ),
    );
  }

  Widget _makeDropDown<T>(String displayText, List<T> dropDownItems, T? value,
      void Function(T?) modUser) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(displayText, style: TextStyle(fontSize: 16)),
          DropdownButton<T>(
            autofocus: false,
            isExpanded: true,
            value: value,
            items: dropDownItems
                .map((item) =>
                    DropdownMenuItem(child: Text(item.toString()), value: item))
                .toList(),
            onChanged: (T? change) => setState(
              () {
                modUser(change);
                changedSetting = true;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeCheckBox(
      String displayText, bool? value, void Function(bool?) modUser) {
    return Row(children: [
      Text(displayText),
      Spacer(),
      //Need for checkboxes in the foodprefs dropdown menu to change when pressed
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setChildState) {
        return Checkbox(
          checkColor: Colors.white,
          fillColor:
              MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                  // Color when the checkbox is checked
                  return Theme.of(context).colorScheme.primary; // Change this to the desired inactive color
                  } else {
                  // Color when the checkbox is unchecked
                  return Theme.of(context).colorScheme.background;
                  }
                },
              ),
          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
          value: value,
          onChanged: (bool? change) {
            setChildState(() {
              modUser(change);
              value = change;
              changedSetting = true;
            });
            setState(() {});
          },
        );
      })
    ]);
  }

  Widget _makeGrayTextbox(String displayText) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Theme.of(context).colorScheme.tertiary,
        padding: EdgeInsets.fromLTRB(12, 28, 12, 28),
        child: Text(displayText),
      ),
    );
  }

  Widget _makePadding(List<Widget> inside) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: inside,
      ),
    );
  }

  String _makeTimestamp() {
    //TODO: TESTING ONLY SO THAT IT ACTUALLY WORKS! (not a testing member)
    // Reset this later
    //DateTime memberSince = DateTime.parse(user.member_at);
    String locale = Localizations.localeOf(context).toString();
    DateTime memberSince = DateTime.parse("2021-08-09 19:50");
    return DateFormat("HH:mm, d MMM y", locale).format(memberSince);
  }

  Widget Function(BuildContext) _savingPopup() {
    var t = AppLocalizations.of(context)!;
    return (BuildContext context) => SimpleDialog(
          title: Text(t.settingsSaving,
              style: Theme.of(context).textTheme.headlineSmall),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          children: [
            Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.orange[600],
                ),
              ],
            ),
          ],
        );
  }

  Widget Function(BuildContext) _failedPopup() {
    var t = AppLocalizations.of(context)!;
    return (BuildContext context) => SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          title: Text(t.settingsWarning,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(t.settingsWarningText,),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.check, color: Theme.of(context).colorScheme.inverseSurface),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        );
  }

  Widget Function(BuildContext) _saveOnClosePopup() {
    var t = AppLocalizations.of(context)!;
    return (BuildContext context) => SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          title: Text(t.settingsUnsaved,
              style: Theme.of(context).textTheme.headlineSmall),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Text(t.settingsUnsavedText),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.settingsDiscard)),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      _save();
                      Navigator.pop(context);
                    },
                    child: Text(t.settingsSave),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        );
  }

  void _save() async {
    FocusScope.of(context).unfocus();
    showDialog(context: context, builder: _savingPopup());
    if (!extraPref) user!.food_custom = "";
    locator<UserService>().updateUser(user!).then((value) {
      setState(() {
        extraPref = user!.food_custom != "";
        changedSetting = false;
      });
      Navigator.pop(context);
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(context: context, builder: _failedPopup());
      },
    );
  }
}
