import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/screens/guild_meeting/candidacy_poster.dart';
import 'package:fsek_mobile/screens/guild_meeting/other_documents.dart';
import 'package:fsek_mobile/screens/guild_meeting/about_guild_meeting.dart';
import 'package:fsek_mobile/screens/guild_meeting/propositions.dart';
import 'package:fsek_mobile/screens/guild_meeting/motions.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    double edgePadding = MediaQuery.of(context).size.width / 25;
    String backgroundPath = "assets/img/ht_23_background.png";
    return Stack(children: [
      Image.asset(
        backgroundPath,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              edgePadding,
              MediaQuery.of(context).size.height / 2.69420 /* lemao */,
              edgePadding,
              0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(t.guildMeetingButtonAbout, AboutGuildMeetingPage()),
                    button(t.guildMeetingButtonPoster, CandidacyPosterPage()),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    button(t.guildMeetingButtonMotions, MotionsPage()),
                    button(t.guildMeetingButtonProposition, PropositionsPage()),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width /
                            48), // space so that the fifth button matches up with the grid above
                    button(t.guildMeetingButtonOther, OtherDocumentsPage()),
                  ],
                ),
                Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget button(String text, Widget destination) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Text(text),
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Color(0xFF667760).withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(MediaQuery.of(context).size.width / 2.4, 80)),
    );
  }
}
