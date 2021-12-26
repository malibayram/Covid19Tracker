import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' show DateFormat;

import './cases_detail_page.dart';
import './country_search_select_page.dart';
import '../controllers/country_detail_page_controller.dart';
import '../models/statistics.dart';
import '../utilities/constant.dart';
import '../widgets/counter.dart';
import '../widgets/my_header.dart';

class CountryDetailPage extends StatelessWidget {
  final CountryDetailPageController controller;

  const CountryDetailPage({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Statistics?>(
      future: controller.getStatistics(),
      builder: (box, snapshot) {
        if (snapshot.hasData) {
          controller.statistics = snapshot.data;
          if (controller.statistics!.deaths!.newValue != "") {}
          return ListView(
            children: [
              Stack(
                children: [
                  const MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    textTop: "All you need",
                    textBottom: "is stay at home.",
                    offset: 0,
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => CountrySearchSelectPage(
                              selectedItem: controller.country,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                controller.country,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset("assets/icons/dropdown.svg")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Case Update\n",
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text:
                                    "Update at ${DateFormat("d MMMM yyyy EEEE").format(controller.statistics!.day)}",
                                style: const TextStyle(
                                  color: kTextLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => CasesDetailPage(
                                  cases: controller.statistics!.cases!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "See Detail",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(
                            controller.statistics!.cases!.newValue,
                          ),
                          title: "New",
                        ),
                        const SizedBox(width: 8),
                        Counter(
                          color: kDeathColor,
                          number: controller.statistics!.cases!.active,
                          title: "Active",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tests Update",
                        style: kTitleTextstyle,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(
                            controller.statistics!.tests!.s1MPop,
                          ),
                          title: "s1MPop",
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Counter(
                          color: kDeathColor,
                          number: controller.statistics!.tests!.total,
                          title: "Total",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deaths Update",
                        style: kTitleTextstyle,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(
                            controller.statistics!.deaths!.newValue,
                          ),
                          title: "New",
                        ),
                        const SizedBox(width: 8),
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(
                            controller.statistics!.deaths!.s1MPop,
                          ),
                          title: "s1MPop",
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Counter(
                          color: kDeathColor,
                          number: controller.statistics!.deaths!.total,
                          title: "Total",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(20),
                      height: 178,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/map.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
