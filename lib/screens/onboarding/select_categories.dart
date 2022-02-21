import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:cumbialive/screens/onboarding/widgets/points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens.dart';
import 'widgets/category_container.dart';

class SelectCategories extends StatefulWidget {
  SelectCategories({Key key}) : super(key: key);

  @override
  _SelectCategoriesState createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  final TextEditingController categoryController = TextEditingController();

  List<LiveCategory> categoriesOnboarding = [];
  @override
  void initState() {
    setState(() {
      categoriesOnboarding = categories;
      for (int i = 0; i < categories.length; i++) {
        categoriesOnboarding[i].isSelected = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CatapultaScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Points(parte: '4'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '¡Conozcámonos!',
                style: TextStyle(
                  fontSize: 30,
                  color: Palette.cumbiaDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
              child: Text(
                'Escoge las categorías de tu interés',
                style: TextStyle(
                  fontSize: 14,
                  color: Palette.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryContainer(
                    category: categoriesOnboarding[0],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[0].isSelected) {
                          categoriesOnboarding[0].isSelected = false;
                        } else {
                          categoriesOnboarding[0].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[1],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[1].isSelected) {
                          categoriesOnboarding[1].isSelected = false;
                        } else {
                          categoriesOnboarding[1].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[2],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[2].isSelected) {
                          categoriesOnboarding[2].isSelected = false;
                        } else {
                          categoriesOnboarding[2].isSelected = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryContainer(
                    category: categoriesOnboarding[3],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[3].isSelected) {
                          categoriesOnboarding[3].isSelected = false;
                        } else {
                          categoriesOnboarding[3].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[4],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[4].isSelected) {
                          categoriesOnboarding[4].isSelected = false;
                        } else {
                          categoriesOnboarding[4].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[5],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[5].isSelected) {
                          categoriesOnboarding[5].isSelected = false;
                        } else {
                          categoriesOnboarding[5].isSelected = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryContainer(
                    category: categoriesOnboarding[6],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[6].isSelected) {
                          categoriesOnboarding[6].isSelected = false;
                        } else {
                          categoriesOnboarding[6].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[7],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[7].isSelected) {
                          categoriesOnboarding[7].isSelected = false;
                        } else {
                          categoriesOnboarding[7].isSelected = true;
                        }
                      });
                    },
                  ),
                  CategoryContainer(
                    category: categoriesOnboarding[8],
                    onPressed: () {
                      setState(() {
                        if (categoriesOnboarding[8].isSelected) {
                          categoriesOnboarding[8].isSelected = false;
                        } else {
                          categoriesOnboarding[8].isSelected = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            CatapultaSpace(),
            CatapultaSpace(),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                updateCategoryVote();
              },
              child: Container(
                color: Palette.black,
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Finalizar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Palette.white,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateCategoryVote() async {
    for (int i = 0; i < categories.length; i++) {
      LogMessage.getSuccess("ACTUALICÉ CATEGORÍAS");

      if (categoriesOnboarding[i].isSelected) {
        References.categorias.doc(categoriesOnboarding[i].id).update({
          'votes': categoriesOnboarding[i].votes++,
        });
      }
    }
    References.categorias.get().then((querySnapshot) {
      LogMessage.getSuccess("CATEGORÍAS");
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          categories.add(
            LiveCategory(
              isSelected: doc.data()["isSelected"] ?? false,
              id: doc.id,
              name: doc.data()["name"],
              votes: doc.data()["votes"],
            ),
          );
        });
      }
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }).catchError((e) {
      LogMessage.getError("CATEGORÍAS", e);
    });
  }
}
