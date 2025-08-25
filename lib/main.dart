import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  //await dotenv.load(fileName: ".env"); // .env 파일 로드
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('home'),
    );
  }
}
