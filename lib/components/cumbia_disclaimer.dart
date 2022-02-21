import 'package:flutter/cupertino.dart';
import 'package:cumbialive/config/config.dart';

class CumbiaDisclaimer extends StatelessWidget {
  final String name;
  final String label;

  const CumbiaDisclaimer({
    @required this.name,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: RichText(
        overflow:  TextOverflow.ellipsis,
        maxLines: 3,
        textAlign: TextAlign.start,
        text: TextSpan(
          text: "$name · ",
           style: Styles.tittleLiveLbl,
           children: <TextSpan>[
            TextSpan(
              text: '$label',
              style: Styles.descriptionLiveLbl,
            ),

          ],
        ),
      ),
    );
  }
}
