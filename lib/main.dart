import 'package:flutter/material.dart';
import 'package:flutter_movie_market/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  //await dotenv.load(fileName: ".env"); // .env 파일 로드
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '무비 마켓',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF0E0E0F)),
      home: HomePage(),
    );
  }
}
