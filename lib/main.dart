import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Adım 1'de Firebase burada başlatılacak:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive (Yerel Veritabanı) Başlatma
  await Hive.initFlutter();
  // İleride: Hive.registerAdapter(TaskAdapter());
  // İleride: await Hive.openBox('tasks');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişisel Ajanda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Kişisel Ajanda Kurulumu Başarılı!\nAdım 1: Firebase Bekleniyor...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}