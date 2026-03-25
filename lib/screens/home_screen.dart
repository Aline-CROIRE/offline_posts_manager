import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../utils/styles.dart';
import '../widgets/post_card.dart';
import 'add_edit_post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppStyles.mainGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("OFFLINE POSTS", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                onChanged: (v) => context.read<PostProvider>().filterPosts(v),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search posts...",
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              child: Consumer<PostProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) return const Center(child: CircularProgressIndicator(color: Colors.white));
                  if (provider.posts.isEmpty) return const Center(child: Text("No records found.", style: TextStyle(color: Colors.white54)));
                  return ListView.builder(
                    itemCount: provider.posts.length,
                    itemBuilder: (context, index) => PostCard(post: provider.posts[index]),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditPostScreen())),
          label: const Text("NEW LOG", style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
          icon: const Icon(Icons.add, color: Color(0xFF00695C)),
        ),
      ),
    );
  }
}