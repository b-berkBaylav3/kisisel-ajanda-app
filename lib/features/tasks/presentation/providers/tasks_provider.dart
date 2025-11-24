import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task_model.dart';
import '../../data/services/tasks_service.dart';

// Servis sağlayıcısı
final tasksServiceProvider = Provider((ref) => TasksService());

// Görev Listesi Yönetimi (StateNotifier)
class TasksNotifier extends StateNotifier<List<Task>> {
  final TasksService _service;

  TasksNotifier(this._service) : super([]) {
    loadTasks(); // Başlarken yükle
  }

  // Görevleri Yükle
  Future<void> loadTasks() async {
    final tasks = await _service.getAllTasks();
    state = tasks;
  }

  // Görev Ekle
  Future<void> addTask(String title, String desc, DateTime date, TaskPriority priority) async {
    await _service.addTask(
      title: title,
      description: desc,
      date: date,
      priority: priority,
    );
    await loadTasks(); // Listeyi yenile
  }

  // Durum Değiştir (Tamamlandı/Tamamlanmadı)
  Future<void> toggleStatus(Task task) async {
    await _service.toggleTaskStatus(task);
    await loadTasks(); // Listeyi yenile (UI güncellensin diye)
  }

  // Görev Sil
  Future<void> deleteTask(Task task) async {
    await _service.deleteTask(task.id); // Modelde ID string ise task.id, dynamic ise task.key
    await loadTasks();
  }
}

// UI'ın dinleyeceği ana sağlayıcı
final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final service = ref.watch(tasksServiceProvider);
  return TasksNotifier(service);
});