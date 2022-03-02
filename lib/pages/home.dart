import 'package:flutter/material.dart';
import 'package:hidush/components/hidush_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: <Widget>[
          for (int i = 0; i < 20; i++)
            const HidushCard(
              source: 'תלמוד בבלי',
              sourceDetails: 'דף ז עמוד ב',
              quota: '״בראשית ברא השם את השמיים ואת הארץ״',
              peerosh:
                  'אין המקרא הזה אומר אלא דרשני, כמו שדרשוהו רבותינו ז״ל שהתורה נקראת ראשית דרכו וישראל נקראים ראשית',
              labels: ['תורה', 'גמרא'],
              rabbi: 'הרב מאור חי',
              rabbiImage: 'assets/images/rabbi/rav-maor.png',
            ),
        ],
      ),
    );
  }
}
