import 'package:cumbialive/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({
    Key key,
    this.onPressed,
    @required this.percent,
    @required this.step,
    this.isDark = false,
    this.text = '',
  }) : super(key: key);

  final VoidCallback onPressed;
  final double percent;
  final String step;
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 16, 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoNavigationBarBackButton(
              color: isDark ? Palette.white : Palette.black,
              onPressed: onPressed,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Palette.white :Palette.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 65,
              lineWidth: 5.0,
              animation: true,
              percent: percent,
              backgroundColor: Palette.grey,
              progressColor: Palette.cumbiaLight,
              center: Text(
                step,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: isDark ? Palette.white :Palette.black
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
