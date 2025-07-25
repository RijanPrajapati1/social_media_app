import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/life_cycle_event_handler.dart';
import 'package:social_media_app/landing/landing_page.dart';
import 'package:social_media_app/screens/mainscreen.dart';
import 'package:social_media_app/sensor/gyro_sensor.dart';
import 'package:social_media_app/services/user_service.dart';
import 'package:social_media_app/utils/config.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/providers.dart';
import 'package:social_media_app/view_models/theme/theme_view_model.dart';

//firebase setupped for backend database and flutter and dart for frontend
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, Widget? child) {
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: themeData(
              notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, snapshot) {
                return GyroscopeTiltView(
                  child: snapshot.hasData ? TabScreen() : Landing(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(theme.textTheme),
    );
  }
}
