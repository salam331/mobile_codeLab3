import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTaskScreen extends StatelessWidget {
  final String taskId;

  const DeleteTaskScreen({Key? key, required this.taskId}) : super(key: key);

  // Fungsi untuk menghapus task dari Firestore
  Future<void> _deleteTask(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks') // Gantilah dengan nama koleksi Anda
          .doc(taskId)
          .delete();
      print("Task berhasil dihapus");
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah hapus
    } catch (e) {
      print("Gagal menghapus task: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus task')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hapus Task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Apakah Anda yakin ingin menghapus task ini?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _deleteTask(context); // Panggil fungsi hapus task
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Hapus'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
