import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/models/documents/election_document.dart';
import 'package:fsek_mobile/screens/guild_meeting/pdf.dart';
import 'package:fsek_mobile/services/service_locator.dart';
import 'package:fsek_mobile/services/theme.service.dart';

class PropositionCard extends StatefulWidget {
  final ElectionDocument? proposition;

  const PropositionCard({Key? key, required this.proposition})
      : super(key: key);

  @override
  _PropositionCardState createState() => _PropositionCardState();
}

class _PropositionCardState extends State<PropositionCard> {
  Color buttonColor = locator<ThemeService>().theme.colorScheme.primary.withOpacity(0.4);
  Color backgroundColor = locator<ThemeService>().theme.colorScheme.secondary.withOpacity(0.3);
  Color bottomColor = locator<ThemeService>().theme.colorScheme.onSecondary.withOpacity(0.7);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return widget.proposition == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(bottom: BorderSide(color: bottomColor))),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(children: [
              Center(
                  child: Text(
                widget.proposition!.document_name!,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: InkWell(
                          onTap: () => {openFile(widget.proposition!)},
                          child: ListTile(
                            tileColor: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Center(
                                child: Text(
                              t.readProposition,
                            )),
                            visualDensity: VisualDensity(vertical: -3),
                          ))),
                ],
              )
            ]));
  }

  void openFile(ElectionDocument document) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PdfPage(url: document.url!, title: document.document_name!)));
  }
}
