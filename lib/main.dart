import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/tasks/data/models/task_model.dart';

// İŞTE EKSİK OLAN SATIR BU:
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Başlatma
  await Hive.initFlutter();

  // Adapter'ları Tanıt
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  // Veri Kutusunu Aç
  await Hive.openBox<Task>('tasksBox');

  // Türkçe Tarih Formatı
  await initializeDateFormatting('tr_TR', null);

  // Bildirim Servisini Başlat (Artık hata vermeyecek)
  await NotificationService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kişisel Ajanda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
    );
  }
}