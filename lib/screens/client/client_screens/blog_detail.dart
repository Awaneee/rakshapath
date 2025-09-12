import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../models/blog_post.dart';

class BlogDetailPage extends StatefulWidget {
  final BlogPost blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future<void> _speak() async {
    if (isPlaying) {
      await flutterTts.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      setState(() {
        isPlaying = true;
      });
      await flutterTts.speak(widget.blog.content);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildContent(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speak,
        backgroundColor: Color(0xFF0284C7),
        child: Icon(
          isPlaying ? Icons.stop : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 240,
      floating: false,
      pinned: true,
      backgroundColor: Color(0xFF0284C7),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.blog.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.blog.imageAsset,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.blog.category,
                style: TextStyle(
                  color: Color(0xFF0284C7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.access_time, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              widget.blog.readTime,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF0284C7).withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: Color(0xFF0284C7),
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.blog.author,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.blog.date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.blog.content.split('\n\n').map((paragraph) {
        if (paragraph.startsWith('🥾') ||
            paragraph.startsWith('🧳') ||
            paragraph.startsWith('⚠️') ||
            paragraph.startsWith('🛡️') ||
            paragraph.startsWith('🌍') ||
            paragraph.startsWith('🏯') ||
            paragraph.startsWith('📸') ||
            paragraph.startsWith('🎎') ||
            paragraph.startsWith('⏰')) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              paragraph,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                height: 1.5,
                color: Color(0xFF1A1A1A), // Almost black for headings
                letterSpacing: 0.2,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            paragraph,
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Color(0xFF333333), // Dark gray for better readability
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        );
      }).toList(),
    );
  }
}
