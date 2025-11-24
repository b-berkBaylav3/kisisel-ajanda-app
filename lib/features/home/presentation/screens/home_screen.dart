import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_ajanda/core/constants/app_colors.dart';

// DİKKAT: Buradaki importlar artık tam adres kullanıyor
import 'package:kisisel_ajanda/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:kisisel_ajanda/features/tasks/presentation/widgets/add_task_modal.dart';
import 'package:kisisel_ajanda/features/tasks/presentation/widgets/task_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider'ı dinle (Listeyi getir)
    final taskList = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Programım',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: false,
      ),
      // Eğer liste boşsa resim göster, doluysa listeyi göster
      body: taskList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Henüz bir planın yok.\nArtıya basarak başla!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final task = taskList[index];
            return TaskTile(
              task: task,
              onToggle: () {
                ref.read(tasksProvider.notifier).toggleStatus(task);
              },
              onDelete: () {
                ref.read(tasksProvider.notifier).deleteTask(task);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: AppColors.primary),
        onPressed: () {
          // Bottom Sheet'i aç
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Tam ekran klavye desteği için
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const AddTaskModal(),
          );
        },
      ),
    );
  }
}