import 'package:digital_health_stratup_assignment/controller/newsprovider.dart';
import 'package:digital_health_stratup_assignment/views/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => news_provider()),
        ChangeNotifierProvider(create: (context) => PersistentTabController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const PersistentNavbar(),
      ),
    );
  }
}
