import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'; // debugPrint için

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Başlatma Logu
    debugPrint("🔔 NotificationService: Başlatılıyor...");

    tz.initializeTimeZones();

    // Timezone hatasını önlemek için güvenli yöntem
    String timeZoneName;
    try {
      timeZoneName = await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      timeZoneName = 'UTC'; // Hata olursa UTC kullan
    }

    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      // Eğer telefonun timezone'u veritabanında yoksa UTC yap
      tz.setLocalLocation(tz.UTC);
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _requestPermissions();

    debugPrint("🔔 NotificationService: Başlatma Tamamlandı!");
  }

  Future<void> _requestPermissions() async {
    // İzinleri sırayla ve ısrarla isteyelim
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    debugPrint("🔔 BİLDİRİM DENEMESİ: $scheduledTime zamanına kurulmaya çalışılıyor...");
    debugPrint("🔔 ŞU ANKİ SAAT: ${DateTime.now()}");

    // Geçmiş zaman kontrolü
    if (scheduledTime.isBefore(DateTime.now())) {
      debugPrint("❌ HATA: Seçilen zaman geçmişte kalmış! Bildirim kurulmadı.");
      return;
    }

    try {
      // Bildirim Detayları
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'main_channel',
        'Hatırlatıcılar',
        channelDescription: 'Görev hatırlatıcıları',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      const NotificationDetails details = NotificationDetails(android: androidDetails);

      // TZDateTime dönüşümü (En kritik yer)
      final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Doze modunda bile çalıştır
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );

      debugPrint("✅ BAŞARILI: Bildirim ID: $id başarıyla kuruldu!");

    } catch (e) {
      debugPrint("❌ BİLDİRİM KURMA HATASI: $e");
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    debugPrint("🗑️ Bildirim İptal Edildi: ID $id");
  }
}