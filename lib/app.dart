import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'base/flavour/environment.dart';
import 'base/flavour/flavour.dart';
import 'base/styles/themes/app_themes.dart';

Future<void> startApp(Flavour flavour) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.instance.initConfig(flavour);
  runApp(MyApp(flavour: flavour));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.flavour,
  }) : super(key: key);
  final Flavour flavour;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // title: AppLocalizations.of(context).appVariant(widget.flavour.name),
      debugShowCheckedModeBanner: Environment.instance.config.showBanner,
      theme: AppThemes.instance.light,
      darkTheme: AppThemes.instance.dark,
      themeMode: Environment.instance.themeMode,
      locale: Environment.instance.selectedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppPages.router,
    );
  }
}
