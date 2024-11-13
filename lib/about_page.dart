import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To-Do List App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi To-Do List ini memungkinkan Anda untuk mencatat dan mengatur tugas sehari-hari Anda. Dengan aplikasi ini, Anda dapat menambahkan, menghapus, dan mengelompokkan tugas berdasarkan kategori serta menandai tugas yang telah selesai.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Fitur-fitur aplikasi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- Menambahkan tugas baru'),
            Text('- Menandai tugas sebagai selesai'),
            Text('- Kategori dan prioritas untuk tugas'),
            Text('- Simpan data secara lokal'),
          ],
        ),
      ),
    );
  }
}
