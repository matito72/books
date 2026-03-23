import 'dart:async';

import 'package:book/config/com_area.dart';
import 'package:book/config/routes.dart';
import 'package:book/config/theme/books_style.dart';
import 'package:book/features/libreria/bloc/libreria.bloc.dart';
import 'package:book/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:book/features/libreria/data/models/libreria_isar.module.dart';
import 'package:book/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:book/injection_container.dart';
import 'package:book/screens/home_libreria.dart';
import 'package:book/screens/home_libri_libreria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  final String assetKey = 'assets/shaders/glitch.glsl';

  @override
  State<MyApp> createState() => _MyAppState();
}

/// LINUX
///   Per fissare la dimensione iniziale della finestra:
///     /home/titol/prj/book_test/linux/runner/my_application.cc   --> circa riga 56
///     gtk_window_set_default_size(window, 1280, 720);
///
///   Per ottenere l'eseguibile:
///     flutter build linux        =>   /home/titol/prj/book_test/build/linux/x64/release/bundle
///
/// ANDROID
///   Compila diverse APK, una per architettura:
///     flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
class _MyAppState extends State<MyApp> {
  // Init Glitch
  // int count = 0; // for the glitched counter
  double _shadertime = 0;
  Timer? _timer;
  bool isShaderOn = false;

  // --------------------------------------------------
  // INIT
  // --------------------------------------------------
  List<Widget> widgetOptions = <Widget>[];
  late Widget buildPageView;
  int _selectedIndex = 1;

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  BottomNavigationBar? _bottomNavigationBar;
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();
    sl<LibreriaBloc>().add(InitLibreriaEvent());
    ComArea.initApp = false;

    // Glitch
    // timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
    //   setState(() {
    //     shadertime += 0.016;
    //   });
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();

    // Glitch
    _timer?.cancel();

    super.dispose();
  }

  // Inizializza/Apre una libreria
  void _goToHomeLibriLibreria() async {
    List<LibreriaIsarModel> lstLibreriaSelClone = List.from(
      ComArea.lstLibrerieInUso,
    );
    lstLibreriaSelClone.sort((a, b) => a.sigla.compareTo(b.sigla));

    await sl<DbLibreriaIsarService>().changeLibreriaDefault(
      lstLibreriaSelClone,
    );

    setState(() {
      if (widgetOptions.length == 2) {
        widgetOptions.removeAt(1);
      }

      ComArea.initApp = true;
      widgetOptions.add(const HomeLibriLibreriaScreen());

      _selectedIndex = 1;
      updBottomNavigationBar();

      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  void _onOffLightBulb() {
    setState(() {
      isShaderOn = !isShaderOn;

      // Cancella SEMPRE il timer esistente prima di fare altro
      _timer?.cancel();
      _timer = null;

      if (isShaderOn) {
        _timer = Timer.periodic(const Duration(milliseconds: 16), (t) {
          setState(() {
            _shadertime += 0.016;
          });
        });
      } else {
        _shadertime = 0;
      }

      // 1. Trova l'indice del primo widget di quel tipo
      int index = widgetOptions.indexWhere((w) => w is HomeLibreriaScreen);

      if (index != -1) {
        // 2. Sostituisci l'elemento all'indice trovato con la nuova istanza
        widgetOptions[index] = HomeLibreriaScreen(fn: _goToHomeLibriLibreria, fnOnOff: _onOffLightBulb, initShader: isShaderOn);
        // widgetOptions[index] = HomeLibreriaScreen(fn: _goToHomeLibriLibreria, fnOnOff: _onOffLightBulb, initShader: false);
      }
      // else {
      //   // non esiste ...
      //   widgetOptions.add(HomeLibreriaScreen());
      // }
    });
  }

  void updBottomNavigationBar() {
    _bottomNavigationBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(MdiIcons.bookshelf), label: ''),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      backgroundColor: BookStyle
          .bookStyleTheme
          .scaffoldBackgroundColor, // const Color.fromARGB(255, 75, 64, 64),
      onTap: (index) {
        bottomTapped(index);
      },
    );
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      updBottomNavigationBar();
    });
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      updBottomNavigationBar();
    });
  }

  Widget buildPageViewWidget() {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) async {
              pageChanged(index);
            },
            children: widgetOptions,
          ),
        ),
        bottomNavigationBar: _bottomNavigationBar,
      ),
    );
  }

  Widget shaderOn() {
    return ShaderBuilder(
      assetKey: widget.assetKey,
          (context, shader, child) {
        return AnimatedSampler(
              (image, size, canvas) {
            final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, _shadertime)
              ..setImageSampler(0, image);

            canvas.drawRect(
              Offset.zero & size,
              Paint()..shader = shader,
            );
          },
          child: child!,
        );
      },
      child: BlocProvider<LibreriaBloc>(
        create: (context) => sl()..add(const LoadLibreriaEvent()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: BookStyle.bookStyleTheme,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            home: buildPageViewWidget(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              FlutterQuillLocalizations.delegate,
            ]
        ),
      ),
    );
  }

  // Widget shaderOn() {
  //   return BlocProvider<LibreriaBloc>(
  //     create: (context) => sl()..add(const LoadLibreriaEvent()),
  //     child: MaterialApp(
  //         debugShowCheckedModeBanner: false,
  //         theme: BookStyle.bookStyleTheme,
  //         onGenerateRoute: AppRoutes.onGenerateRoutes,
  //         home: buildPageViewWidget(),
  //         localizationsDelegates: const [
  //           GlobalMaterialLocalizations.delegate,
  //           GlobalCupertinoLocalizations.delegate,
  //           GlobalWidgetsLocalizations.delegate,
  //           FlutterQuillLocalizations.delegate,
  //         ]
  //     ),
  //   );
  // }

  Widget shaderOff() {
    return BlocProvider<LibreriaBloc>(
      create: (context) => sl()..add(const LoadLibreriaEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: BookStyle.bookStyleTheme,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: buildPageViewWidget(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widgetOptions.isEmpty) {
      // DEFAULT - PAGE
      widgetOptions.add(HomeLibreriaScreen(fn: _goToHomeLibriLibreria, fnOnOff: _onOffLightBulb, initShader: isShaderOn));
      // widgetOptions.add(HomeLibreriaScreen(fn: _goToHomeLibriLibreria, fnOnOff: _onOffLightBulb, initShader: false));
    }

    return isShaderOn ? shaderOn() : shaderOff();
    // return shaderOff();
  }
}
