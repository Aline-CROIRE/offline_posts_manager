import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/database_helper.dart';

class PostProvider with ChangeNotifier {
  List<Post> _allPosts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = false;

  List<Post> get posts => _filteredPosts;
  bool get isLoading => _isLoading;

  Future<void> refreshPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allPosts = await DatabaseHelper.instance.getAllPosts();
      _filteredPosts = _allPosts;
    } catch (e) {
      debugPrint("DB Error: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> addPost(String title, String content) async {
    final now = DateTime.now().toIso8601String();
    final post = Post(title: title, content: content, createdAt: now, updatedAt: now);
    await DatabaseHelper.instance.insertPost(post);
    await refreshPosts();
    return "Log saved to local storage!";
  }

  Future<String?> updatePost(Post post) async {
    final updated = post.copyWith(updatedAt: DateTime.now().toIso8601String());
    await DatabaseHelper.instance.updatePost(updated);
    await refreshPosts();
    return "Log updated successfully!";
  }

  Future<String?> deletePost(int id) async {
    await DatabaseHelper.instance.deletePost(id);
    await refreshPosts();
    return "Log deleted permanently.";
  }

  void filterPosts(String query) {
    _filteredPosts = _allPosts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()) || 
                      p.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}