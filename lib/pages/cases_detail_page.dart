import 'package:flutter/material.dart';

import '../models/cases.dart';
import '../utilities/constant.dart';
import '../widgets/counter.dart';

class CasesDetailPage extends StatelessWidget {
  final Cases cases;
  const CasesDetailPage({Key? key, required this.cases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cases")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Counter(
              color: kInfectedColor,
              number: int.parse(
                cases.newValue,
              ),
              title: "New",
            ),
            const Divider(),
            Counter(
              color: kDeathColor,
              number: cases.active,
              title: "Active",
            ),
            const Divider(),
            Counter(
              color: kRecovercolor,
              number: cases.recovered,
              title: "Recovered",
            ),
            const Divider(),
            Counter(
              color: kDeathColor,
              number: int.parse(
                cases.s1MPop,
              ),
              title: "s1MPop",
            ),
            const Divider(),
            Counter(
              color: kInfectedColor,
              number: cases.critical,
              title: "Critical",
            ),
            const Divider(),
            Counter(
              color: kDeathColor,
              number: cases.total,
              title: "Total",
            ),
          ],
        ),
      ),
    );
  }
}
