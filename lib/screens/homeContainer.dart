import 'package:fighthunger/screens/events.dart';
import 'package:fighthunger/screens/home_page.dart';
import 'package:fighthunger/screens/ideaBoard.dart';
import 'package:fighthunger/screens/volunteer.dart';
import 'package:fighthunger/style/global.dart';
import 'package:flutter/material.dart';

class HomePageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: new Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            Volunteer(),
            Events(),
            Ideas(),
          ],
        ),
        bottomNavigationBar: Container(
          // margin: CurrentDevice.hasNotch ? EdgeInsets.only(bottom:20) : null,
          child: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.pan_tool_rounded),
              ),
              Tab(
                icon: new Icon(Icons.language_outlined),
              ),
              Tab(
                icon: new Icon(Icons.lightbulb_outline),
              ),
            ],
            labelColor: pageGreyColor,
            unselectedLabelColor: pageGreyColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: magenta,
          )
          
        ),
      )
    );
  }
}