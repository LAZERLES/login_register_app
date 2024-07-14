import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../service/page_service.dart';

class PageDetailScreen extends StatefulWidget {
  final String id;
  const PageDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PageDetailScreen> createState() => _PageDetailScreenState();
}

class _PageDetailScreenState extends State<PageDetailScreen> {
  dynamic _page = {};

  @override
  void initState() {
    super.initState();
    _fetchPage();
  }

  Future<void> _fetchPage() async {
    try {
      final page = await PageService.fetchPage(widget.id);
      setState(() {
        _page = page;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              _page['content'],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
