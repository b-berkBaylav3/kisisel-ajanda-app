import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';

class TasksService {
  // Veri kutusunun (tablonun) adı
  static const String boxName = 'tasksBox';

  // Kutuyu açan ve verileri getiren fonksiyon
  Future<Box<Task>> get _box async => await Hive.openBox<Task>(boxName);

  // 1. Yeni Görev Ekle
  Future<void> addTask({
    required String title,
    required String description,
    required DateTime date,
    required TaskPriority priority,
  }) async {
    final box = await _box;
    final String id = const Uuid().v4(); // Eşsiz ID üret

    final newTask = Task(
      id: id,
      title: title,
      description: description,
      date: date,
      priority: priority,
    );

    // Hive'a kaydet (Key olarak ID kullanıyoruz)
    await box.put(id, newTask);
  }

  // 2. Tüm Görevleri Getir (Tarihe göre sıralı)
  Future<List<Task>> getAllTasks() async {
    final box = await _box;
    final tasks = box.values.toList();

    // Tarihe göre sırala (En yakın tarih en üstte)
    tasks.sort((a, b) => a.date.compareTo(b.date));
    return tasks;
  }

  // 3. Görevi Sil
  Future<void> deleteTask(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  // 4. Tamamlandı/Tamamlanmadı İşaretle
  Future<void> toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save(); // HiveObject sayesinde direkt save() diyebiliyoruz
  }
}