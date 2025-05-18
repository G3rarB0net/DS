import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../repository/social_repository.dart';
import '../notifiers/post_notifier.dart';

class FeedScreen extends StatelessWidget {
  final int userId;
  FeedScreen({super.key, required this.userId});

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PostNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: RefreshIndicator(
        onRefresh: () => notifier.loadPosts(),
        child: Consumer<PostNotifier>(
          builder: (context, state, _) => ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, i) {
              final post = state.posts[i];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context, notifier),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialog(BuildContext context, PostNotifier notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'Body')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final post = Post(title: titleController.text, body: bodyController.text);
              await notifier.addPost(post, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("🔔 Post created!")));
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
