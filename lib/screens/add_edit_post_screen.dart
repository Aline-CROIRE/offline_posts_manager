import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/post_provider.dart';
import '../utils/styles.dart';

class AddEditPostScreen extends StatefulWidget {
  final Post? post;
  const AddEditPostScreen({super.key, this.post});

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? "");
    _contentController = TextEditingController(text: widget.post?.content ?? "");
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;
    final provider = context.read<PostProvider>();
    String? msg;

    if (widget.post == null) {
      msg = await provider.addPost(_titleController.text, _contentController.text);
    } else {
      msg = await provider.updatePost(widget.post!.copyWith(
        title: _titleController.text,
        content: _contentController.text,
      ));
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg!), backgroundColor: AppStyles.successColor));
      // Pop twice if editing from Detail screen to return to Home
      if (widget.post != null) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppStyles.mainGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.post == null ? "NEW LOG" : "EDIT LOG", style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent, 
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(hintText: "Title...", hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none),
              ),
              const Divider(color: Colors.white24),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(hintText: "Write details...", hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _save,
          child: const Icon(Icons.check, color: Color(0xFF00695C)),
        ),
      ),
    );
  }
}