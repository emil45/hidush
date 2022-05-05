import 'dart:developer';

import 'package:flutter/material.dart';

class Rabbi extends StatelessWidget {
  const Rabbi({
    Key? key,
    required this.rabbiImage,
    required this.rabbi,
  }) : super(key: key);

  final String rabbiImage;
  final String rabbi;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            context: context,
            builder: (BuildContext builder) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            rabbi,
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamily: 'NotoSansHebrew',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage(rabbiImage),
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "יליד אלג'יריה שנת ה'תשי''ט. גדל בצרפת ועלה ארצה בשנת תשל''ב. בוגר ישיבת ''מרכז הרב'', למד תורה מפי מו''ר הרב צבי יהודה הכהן קוק זצ''ל ותלמידיו, מפי הרב יהודה ליאון אשכנזי (מניטו) זצ''ל ומפי הרב שלמה בנימין אשלג זצ''ל. משמש כרב ב''מכון מאיר'' ובמכון אורה. מרצה בכיר ליהדות, לימד בטכניון בחיפה, מלמד כיום ב''ראש יהודי'' ובמקומות רבים בארץ בפני הציבור הרחב. משרת בקודש כרבה של קהילת ''בית יהודה'', בקרית משה, ירושלים.",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'NotoSansHebrew', fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              image: AssetImage(rabbiImage),
              height: 25,
              width: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              rabbi,
              style: const TextStyle(fontSize: 12, fontFamily: 'NotoSansHebrew'),
            ),
          ),
        ],
      ),
    );
  }
}
