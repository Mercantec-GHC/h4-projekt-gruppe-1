import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/models/user_stats.dart';
import '../main.dart';
import '../Widgets/profile.dart';
import '../Widgets/appBar.dart';
import '../Widgets/playerStatsBar.dart';
import '../Widgets/MatchHistory.dart';
import '../Widgets/ChangeUsername.dart';
import 'package:provider/provider.dart';



class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFunction("Account"),
      body: AccountPageContent(),
    );
  }
}

class AccountPageContent extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var user = appState.user;

    return SingleChildScrollView(
      
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          PlayerStatsBar(user:user),
          SizedBox(height: 16),
          MatchHistory(user:user),
          //StatsSection(),
          SizedBox(height: 16),
          ChangeUsername(user:user),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}