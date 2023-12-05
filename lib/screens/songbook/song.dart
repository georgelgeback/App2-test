import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fsek_mobile/models/songbook/song.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/services/service_locator.dart';
import 'package:fsek_mobile/services/theme.service.dart';

class SongPage extends StatelessWidget {
  const SongPage({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: locator<ThemeService>().theme.colorScheme.tertiary),
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 16),
                child: Text(
                  song.title!,
                  style: TextStyle(color: locator<ThemeService>().theme.colorScheme.onTertiary, fontSize: 24),
                ),
              ),
              song.melody != null && song.melody != ""
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${t.songbookMelody}: ",
                              style: TextStyle(color: locator<ThemeService>().theme.colorScheme.onTertiary)),
                          TextSpan(
                              text: song.melody!,
                              style: TextStyle(color: locator<ThemeService>().theme.textTheme.labelMedium?.color))
                        ]),
                      ),
                    )
                  : SizedBox.shrink(),
              song.author != null && song.author != ""
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${t.songbookAuthor}: ",
                              style: TextStyle(color: locator<ThemeService>().theme.colorScheme.onTertiary)),
                          TextSpan(
                              text: song.author!,
                              style: TextStyle(color: locator<ThemeService>().theme.textTheme.labelMedium?.color))
                        ]),
                      ),
                    )
                  : SizedBox.shrink(),
            ]),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 6, 14, 14),
            child: Html(
              data: song.content!,
              style: {
                "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5), color: locator<ThemeService>().theme.textTheme.bodyMedium?.color)
              },
            ),
          )
        ])));
  }
}
