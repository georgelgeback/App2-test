import 'package:flutter/material.dart';
import 'package:fsek_mobile/models/songbook/songbookEntry.dart';
import 'package:fsek_mobile/screens/songbook/song.dart';
import 'package:fsek_mobile/screens/songbook/hmmm.dart';
import 'package:fsek_mobile/services/service_locator.dart';
import 'package:fsek_mobile/services/song.service.dart';
import 'package:fsek_mobile/services/songbook.service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fsek_mobile/services/theme.service.dart';
import 'package:fsek_mobile/themes.dart';

class SongbookPage extends StatefulWidget {
  @override
  _SongbookPageState createState() => _SongbookPageState();
}

class _SongbookPageState extends State<SongbookPage> with TickerProviderStateMixin {
  List<SongbookEntry> songs = [];
  List<SongbookEntry> allSongs = [];

  //bad helpvariables that are most likely unneeded
  bool searchFocus = false;
  String initChar = "";

  TextEditingController _controller = TextEditingController();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1400));
    locator<SongbookService>().getSongbook().then((value) => setState(() {
          this.songs = value;
          songs.sort((a, b) => a.title!.compareTo(b.title!)); // handle null?
          allSongs = List.from(songs);
        }));

    setRotation(360);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setRotation(int degrees) {
    final angle = degrees * 3.1415 / 180;

    animation = Tween<double>(begin: 0, end: angle).animate(animationController);
  }

  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return allSongs == []
        ? Scaffold(
            appBar: AppBar(title: Text(t.songbookSongbook)),
            body: Center(child: CircularProgressIndicator(color: locator<ThemeService>().theme.colorScheme.onBackground)))
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnimatedBuilder(
                animation: animation,
                child: Scaffold(
                  appBar: AppBar(title: Text(t.songbookSongbook),
                      backgroundColor: locator<ThemeService>().theme.colorScheme.primary,
                      foregroundColor: locator<ThemeService>().theme.textTheme.titleLarge?.color),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FocusScope(
                          child: Focus(
                        onFocusChange: (focus) {
                          setState(() {
                            searchFocus = focus;
                          });
                        },
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              prefixIcon: searchFocus
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: locator<ThemeService>().theme.colorScheme.onPrimary,
                                      ),
                                      onPressed: () => FocusScope.of(context).unfocus())
                                  : Icon(
                                      Icons.search,
                                      color: locator<ThemeService>().theme.colorScheme.onPrimary,
                                    ),
                              hintText: t.songbookSearch,
                              suffixIcon: _controller.text.length > 0
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      color: locator<ThemeService>().theme.colorScheme.onPrimary,
                                      onPressed: () => setState(() {
                                            _controller.clear();
                                            FocusScope.of(context).unfocus();
                                            songs = allSongs;
                                          }))
                                  : SizedBox.shrink()),
                          onChanged: (search) {
                            //Easteregg:
                            if (search == "hmm") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HmmPage()));
                            } else if (search == "do a barrel roll") {
                              FocusScope.of(context).unfocus();
                              animationController.forward(from: 0);
                            }
                            List<String> searchTerms = search.toLowerCase().trim().split(new RegExp(r"\s+"));
                            setState(() {
                              initChar = "";
                              songs = allSongs.where((song) {
                                return searchTerms.every((term) => song.title!.toLowerCase().contains(term));
                              }).toList();
                            });
                          },
                        ),
                      )),
                      Expanded(
                        child: songs.isNotEmpty
                            ? ListView(
                                children: songs.map((song) => _generateSongTile(song)).toList(),
                              )
                            : Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(t.songbookNoMatches),
                              ),
                      )
                    ],
                  ),
                ),
                //Part of doing a barrel roll
                builder: (context, child) => Transform.rotate(angle: animation.value, child: child)));
  }

  Widget _generateSongTile(SongbookEntry song) {
    //This way of doing it is probably really stupid. but so be it
    List<Widget> index = [];
    if (song.title![0] != initChar) {
      initChar = song.title![0];
      index.add(Container(
        decoration: BoxDecoration(color: locator<ThemeService>().theme.colorScheme.tertiary),
        child: ListTile(
          title: Text(
            initChar,
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelMedium?.color),
          ),
        ),
      ));
    }
    return Column(
      children: index +
          [
            Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: locator<ThemeService>().theme.colorScheme.tertiary),
                )),
                child: InkWell(
                  onTap: () => openSong(song.id!),
                  child: ListTile(title: Text(song.title == null ? "" : song.title!, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color))),
                ))
          ],
    );
  }

  void openSong(int id) {
    locator<SongService>().getSong(id).then((song) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(song: song)));
    });
  }
}
