import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/theme/app_theme.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LanguageProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            return LoaderOverlay(child: child!, overlayWholeScreen: false);
          },
        ),
      ),
    );
  }
}
