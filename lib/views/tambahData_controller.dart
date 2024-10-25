import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahDataController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> addData(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'created_at': FieldValue.serverTimestamp(),
      });
      print("Data berhasil ditambahkan");
      Navigator.pop(context); // Mengembalikan user setelah data ditambahkan
    } catch (e) {
      print("Gagal menambahkan data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan data')),
      );
    }
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
