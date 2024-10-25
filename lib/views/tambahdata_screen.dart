import 'package:code_lab3apps/views/tambahData_controller.dart';
import 'package:flutter/material.dart';

class TambahDataScreen extends StatelessWidget {
  final TambahDataController controller = TambahDataController();

  TambahDataScreen(
      {super.key, required Null Function(dynamic newTask) onTaskAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.addData(context); // Memanggil fungsi tambah data
              },
              child: const Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }
}
