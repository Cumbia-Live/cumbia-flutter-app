import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/components/components.dart';
import 'package:date_format/date_format.dart';

Product p;

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      appBar: CupertinoNavigationBar(
        //actionsForegroundColor: Palette.black,
        border: Border.symmetric(),
        middle: Text(
          p.productName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Palette.black,
          ),
        ),
        backgroundColor: Palette.bgColor,
      ),
      body: CatapultaScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Imagen del producto',
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Calificación',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Expanded(child: printStars(getGeneralRate(), 5.0, context)),
                  Column(
                    children: [
                      Text(
                        getGeneralRate().toString(),
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Palette.cumbiaLight,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          '${p.reviews.length} calificaciones',
                          style: TextStyle(color: Palette.cumbiaLight),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                'Reseñas del producto',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.cumbiaGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              Column(children: getReviews()),
            ],
          ),
        ),
      ),
    );
  }

  double getGeneralRate() {
    int cont = 0;
    for (var i = 0; i < p.reviews.length; i++) {
      cont += p.reviews[i].rate;
    }

    return double.parse((cont / p.reviews.length).toStringAsFixed(1));
  }

  Widget printStars(double stars, double maxStars, BuildContext context) {
    List<Widget> list = [];
    double aux = stars;
    double count = 0;

    while (count < maxStars) {
      if (aux - 1 >= 0) {
        list.add(Icon(
          Icons.star,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
        aux--;
      } else if (aux - 0.5 >= 0) {
        list.add(Icon(
          Icons.star_half,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
        aux -= 0.5;
      } else {
        list.add(Icon(
          Icons.star_border,
          color: Palette.cumbiaLight,
          size: MediaQuery.of(context).size.width / 10,
        ));
      }
      count++;
    }

    return Row(children: list, crossAxisAlignment: CrossAxisAlignment.end);
  }

  List<Widget> getReviews() {
    List<Widget> list = [];
    p.reviews.sort((a, b) => b.date.compareTo(a.date));
    for (var i = 0; i < p.reviews.length; i++) {
      list.add(Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${p.reviews[i].name}',
                        style: TextStyle(
                            color: Palette.cumbiaLight,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatDate(
                            DateTime(
                                DateTime.fromMillisecondsSinceEpoch(
                                        p.reviews[i].date ?? 0)
                                    .year,
                                DateTime.fromMillisecondsSinceEpoch(
                                        p.reviews[i].date ?? 0)
                                    .month,
                                DateTime.fromMillisecondsSinceEpoch(
                                        p.reviews[i].date ?? 0)
                                    .day),
                            ['dd', '/', 'mm', '/', 'yyyy']).toString(),
                        style: TextStyle(
                            color: Palette.cumbiaGrey,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            p.reviews[i].rate >= 1
                                ? Icons.star
                                : Icons.star_border,
                            color: Palette.cumbiaLight,
                          ),
                          Icon(
                            p.reviews[i].rate >= 2
                                ? Icons.star
                                : Icons.star_border,
                            color: Palette.cumbiaLight,
                          ),
                          Icon(
                            p.reviews[i].rate >= 3
                                ? Icons.star
                                : Icons.star_border,
                            color: Palette.cumbiaLight,
                          ),
                          Icon(
                            p.reviews[i].rate >= 4
                                ? Icons.star
                                : Icons.star_border,
                            color: Palette.cumbiaLight,
                          ),
                          Icon(
                            p.reviews[i].rate >= 5
                                ? Icons.star
                                : Icons.star_border,
                            color: Palette.cumbiaLight,
                          ),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '${p.reviews[i].rate}.0',
                        style: TextStyle(color: Palette.cumbiaLight),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Text(
                p.reviews[i].review,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Palette.cumbiaGrey,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ));
      list.add(SizedBox(height: 5.0));
    }
    return list;
  }

  ReviewsScreen(Product pro) {
    p = pro;
  }
}
