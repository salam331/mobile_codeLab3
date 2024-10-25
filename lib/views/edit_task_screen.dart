import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskId; // Untuk menyimpan ID task yang akan diedit

  const EditTaskScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getTaskData(); // Memanggil fungsi untuk mengambil data task berdasarkan taskId
  }

  // Fungsi untuk mengambil data dari Firestore berdasarkan taskId
  Future<void> _getTaskData() async {
    final taskSnapshot = await FirebaseFirestore.instance
        .collection('tasks') // Sesuaikan nama koleksi dengan Firestore Anda
        .doc(widget.taskId)
        .get();

    if (taskSnapshot.exists) {
      final data = taskSnapshot.data()!;
      setState(() {
        _titleController.text = data['title'] ?? '';
        _descriptionController.text = data['description'] ?? '';
      });
    } else {
      print("Task dengan ID tersebut tidak ditemukan");
    }
  }

  // Fungsi untuk menyimpan data yang sudah diedit ke Firestore
  Future<void> _saveTaskData() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'title': _titleController.text,
        'description': _descriptionController.text,
      });
      print("Data task berhasil diperbarui");
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah simpan
    } catch (e) {
      print("Gagal memperbarui data task: $e");
    }
  }

  // Fungsi untuk menghapus task berdasarkan taskId di Firestore
  Future<void> _deleteTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .delete();
      print("Task berhasil dihapus");
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah hapus
    } catch (e) {
      print("Gagal menghapus task: $e");
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan judul';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan deskripsi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveTaskData(); // Simpan task yang diedit
                      }
                    },
                    child: Text('Simpan'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Konfirmasi Hapus'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus task ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteTask().then((_) {
                                  Navigator.pop(context); // Tutup dialog
                                  Navigator.pop(
                                      context); // Kembali ke halaman sebelumnya
                                });
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
