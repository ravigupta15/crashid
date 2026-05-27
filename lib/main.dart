import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/service/notification_service.dart';
import 'package:crashid/core/theme/app_theme.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/di/service_locator.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await ServiceLocator.init();  
 await AppNotificationService.instance.initialize();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LanguageProvider())],
      child: ProviderScope(child: const MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      final provider = Provider.of<LanguageProvider>(context, listen: false);
      String language = GetIt.I<UserManager>().language == "de" ? "de" : 'en';
      provider.setLocale(Locale(language));
    }
  });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(1.0),
          size: const Size(375, 812),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: provider.locale, // The magic happens here
          supportedLocales: const [Locale('en'), Locale('de')],
         localizationsDelegates: AppLocalizations.localizationsDelegates,
          onGenerateTitle: (BuildContext context) => "Crashid",
          themeMode: ThemeMode.light,
          darkTheme: AppTheme.dark,
          theme: AppTheme.light,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            return LoaderOverlay(
              overlayWholeScreen: false,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
