import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peliculas_reversionado/models/person_details.dart';
import 'package:peliculas_reversionado/providers/series_provider.dart';
import 'package:provider/provider.dart';

class PersonSerieDetailsWidget extends StatelessWidget {
  final int actorId;

  const PersonSerieDetailsWidget(this.actorId);

  @override
  Widget build(BuildContext context) {
    final seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: seriesProvider.getPersonSerieDetails(actorId),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                width: 400,
                height: 100,
                child: Center(
                  child: Center(child: CupertinoActivityIndicator()),
                ));
          }

          final PersonDetails actors = snapshot.data!;
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.black45),
                      child: Text(
                          'Nacimiento: '.toUpperCase() +
                              (DateFormat('dd-MM-yyyy')
                                  .format(actors.fullBirthday)),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'muli',
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.black45),
                      child: Text(
                        _getPersonAge(actors.fullBirthday, actors.deathday),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.black45),
                      child: Text(
                        'Lugar de Nacimiento: '.toUpperCase() +
                            actors.fullPlaceOfBirth.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        actors.biography!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'muli'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  String _getPersonAge(birthday, deathday) {
    DateTime dob = birthday;
    if (deathday == null) {
      Duration dura = DateTime.now().difference(dob);
      String differenceInYears = (dura.inDays / 365).floor().toString();
      return 'Edad: $differenceInYears años'.toUpperCase();
    }
    dynamic dod = DateTime.tryParse(deathday);
    Duration dur = dod.difference(dob);
    String differenceInYear = (dur.inDays / 365).floor().toString();
    return 'Fallecimiento: '.toUpperCase() +
        (DateFormat('dd-MM-yyyy').format(dod)) +
        ' ($differenceInYear años)'.toUpperCase();
  }
}
