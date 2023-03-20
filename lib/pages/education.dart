import 'package:flutter/material.dart';
import 'package:spacetools/widgets/shares.dart';
import '../constants.dart';
import '../widgets/custom_widget/app_bar.dart';
import '../widgets/edu_classes.dart';

class Education extends StatelessWidget {
  const Education({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: buildAppBar(context, ['Classes', 'Meetings', 'Bookings'],
              address: address, isEmpty: true),
          body: TabBarView(children: [
            const EduClasses(),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Meetings',
                    style: textTheme(context).bodyLarge,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AddSth(
                      hasButton: false,
                      height: MediaQuery.of(context).size.height / 1.9,
                      subject: 'Meeting Invite',
                      caption: 'You currently have no meetings scheduled'),
                )
              ],
            ),
            const SizedBox()
          ]),
        ));
  }
}
