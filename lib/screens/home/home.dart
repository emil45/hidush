import 'package:flutter/material.dart';
import 'package:hidush/widgets/hidush_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      for (int i = 0; i < 5; i++)
        HidushCard(
          key: Key(i.toString()),
          source: 'תלמוד בבלי',
          sourceDetails: 'דף ז עמוד ב',
          quota: '״בראשית ברא השם את השמיים ואת הארץ״',
          peerosh:
              'אין המקרא הזה אומר אלא דרשני, כמו שדרשוהו רבותינו ז״ל שהתורה נקראת ראשית דרכו וישראל נקראים ראשית',
          labels: const ['תורה', 'גמרא'],
          rabbi: 'הרב מאור חי',
          rabbiImage: 'assets/images/rabbi/rav-maor.png',
          isLiked: true,
          likes: 5,
          shares: 22,
        ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) => cards.elementAt(index),
        itemCount: cards.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
