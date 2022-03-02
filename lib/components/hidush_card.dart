import 'package:flutter/material.dart';
import 'package:hidush/common/utils.dart';

class HidushCard extends StatelessWidget {
  const HidushCard({
    Key? key,
    required this.source,
    required this.sourceDetails,
    required this.quota,
    required this.peerosh,
    required this.rabbi,
    required this.rabbiImage,
    required this.labels,
  }) : super(key: key);

  final String source;
  final String sourceDetails;
  final String quota;
  final String peerosh;
  final String rabbi;
  final String rabbiImage;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source,
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Assistant',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      sourceDetails,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image(
                      image: AssetImage(rabbiImage),
                      height: 45,
                      width: 45,
                    ),
                    Text(rabbi, style: const TextStyle(fontSize: 8)),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(quota),
            ),
            const Divider(
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(peerosh),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  ...labels.map((labelText) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Chip(
                          backgroundColor:
                              labelsColors[labelText] ?? Colors.grey[300],
                          label: Text(labelText),
                        ),
                      ))
                ]),
                Row(
                  children: const [
                    Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
