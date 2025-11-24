import 'package:hive/hive.dart';

// Kod üretimi yapıldığında oluşacak dosyanın adı (Hata verirse aldırma, birazdan üreteceğiz)
part 'task_model.g.dart';

// Öncelik Seviyeleri için Enum
@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

// Ana Görev Modeli
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id; // Eşsiz kimlik (UUID)

  @HiveField(1)
  String title; // Başlık

  @HiveField(2)
  String description; // Açıklama

  @HiveField(3)
  DateTime date; // Yapılacak tarih

  @HiveField(4)
  bool isCompleted; // Tamamlandı mı?

  @HiveField(5)
  TaskPriority priority; // Öncelik (Düşük/Orta/Yüksek)

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.priority = TaskPriority.medium,
  });
}