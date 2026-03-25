import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../utils/styles.dart';
import 'add_edit_post_screen.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().add_jm().format(DateTime.parse(post.updatedAt));

    return Container(
      decoration: const BoxDecoration(gradient: AppStyles.mainGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Updated: $date", style: const TextStyle(color: Colors.white60)),
              const Divider(height: 40, color: Colors.white24),
              Text(post.content, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.6)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditPostScreen(post: post))),
          child: const Icon(Icons.edit, color: Color(0xFF00695C)),
        ),
      ),
    );
  }
}