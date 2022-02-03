import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VariantsList extends StatelessWidget {
  VariantsList({
    Key key,
    @required this.variants,
    @required this.itemCount,
    @required this.product,
    @required this.onTap,
    this.positionAux,
  }) : super(key: key);

  final int itemCount;
  final List<Product> variants;
  final Product product;
  final VoidCallback onTap;
  int positionAux;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101 * itemCount.toDouble(),
      width: MediaQuery.of(context).size.width ,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width ,
            color: Palette.grey.withOpacity(0.25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    color: Palette.white,
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${variants[position].color}/${variants[position].dimension}/${variants[position].size}/${variants[position].material}/${variants[position].style}'
                                  .replaceAll('//', '') ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Palette.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${NumberFormat.simpleCurrency().format(
                              product.price,
                            )} COP'
                                .replaceAll('.00', '')
                                .replaceAll(',', '.'),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          // ignore: lines_longer_than_80_chars
                          '${product.avaliableUnits} ${product.avaliableUnits == 1 ? 'unidad' : 'unidades'}',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  CatapultaSpace(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      positionAux = position;
                      onTap;
                    },
                    child: Icon(
                      Icons.edit,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: itemCount ?? 0,
      ),
    );
  }
}
