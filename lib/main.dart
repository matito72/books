import 'package:books/config/com_area.dart';
import 'package:books/config/routes.dart';
import 'package:books/config/theme/books_style.dart';
import 'package:books/features/libreria/bloc/libreria.bloc.dart';
import 'package:books/features/libreria/bloc/libreria_events.bloc.dart';
import 'package:books/features/libreria/data/models/libreria_isar.module.dart';
import 'package:books/features/libreria/data/services/db_libreria.isar.service.dart';
import 'package:books/screens/home_libreria.dart';
import 'package:books/screens/home_libri_libreria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'injection_container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  }

  @override
  void dispose() {
    // sl<DbLibreriaIsarService>().dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Inizializza/Apre una libreria 
  void _goToHomeLibriLibreria() async {
    List<LibreriaIsarModel> lstLibreriaSelClone = List.from(ComArea.lstLibrerieInUso);
    lstLibreriaSelClone.sort((a, b) => a.sigla.compareTo(b.sigla));

    // if (ComArea.libreriaInUso == null || libreriaSel.sigla != ComArea.libreriaInUso!.sigla)   {
      await sl<DbLibreriaIsarService>().changeLibreriaDefault(lstLibreriaSelClone);
    //   ComArea.libreriaInUso = libreriaSel;
    // }

    setState(() {
      if (widgetOptions.length == 2) {
        widgetOptions.removeAt(1);
      }

      ComArea.initApp = true;
      widgetOptions.add(const HomeLibriLibreriaScreen());
      
      _selectedIndex = 1;
      updBottomNavigationBar();

      _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  void updBottomNavigationBar() {
    _bottomNavigationBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.bookshelf),
          label: '',
        )
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      backgroundColor: BookStyle.bookStyleTheme.scaffoldBackgroundColor, // const Color.fromARGB(255, 75, 64, 64),
      onTap: (index) {
        bottomTapped(index);
      },
    );
  }
  
  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
      updBottomNavigationBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widgetOptions.isEmpty) {
      // DEFAULT - PAGE
      widgetOptions.add(HomeLibreriaScreen(fn: _goToHomeLibriLibreria));
    }
      
    void pageChanged(int index) {
      setState(() {
        _selectedIndex = index;
        updBottomNavigationBar();
      });
    }

    Widget buildPageView() {
      return SafeArea(
        child: Scaffold(
        body: Center(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                pageChanged(index);
              },
              children: widgetOptions,
            )
        ),
        bottomNavigationBar: _bottomNavigationBar,
        ),
      );
    }

    return BlocProvider<LibreriaBloc>(
      create: (context) => sl()..add(const LoadLibreriaEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: BookStyle.bookStyleTheme,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: buildPageView()
      ),
    );

  }

}


  