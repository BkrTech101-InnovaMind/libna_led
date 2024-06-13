import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FooterText extends StatelessWidget {
  const FooterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 2.9),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 35,
              fontWeight: FontWeight.w500,
            ),
            text: "تصميم وتنفيذ نضام التحكم ",
            children: const <InlineSpan>[
              TextSpan(text: "لبنة للإستشارات والتصاميم الهندسيه "),
              TextSpan(text: "778007600"),
            ],
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
