import 'package:flutter/material.dart';
import '../../../models/blog_post.dart';
import 'blog_detail.dart';

class ClientBlogs extends StatefulWidget {
  const ClientBlogs({super.key});

  @override
  State<ClientBlogs> createState() => _ClientBlogsState();
}

class _ClientBlogsState extends State<ClientBlogs> {
  final BlogPost trekkingBlog = BlogPost(
    title: 'Trekking at Nashik: An Adventurer\'s Guide',
    content: '''🥾 Trekking at Nashik: An Adventurer's Guide

Nashik, known for its vineyards and spiritual aura, also hides some of Maharashtra's most scenic trekking routes—like Harihar Fort, Brahmagiri, and Anjneri Hills. These trails offer a mix of breathtaking landscapes, historical charm, and physical challenge. But before lacing up your boots, here's everything you need to know to trek safely and smartly.

🧳 Must-Have Essentials

Trekking Shoes – Good grip is non-negotiable; avoid casual sneakers.

Backpack (20–30L) – Enough to carry water, snacks, and essentials.

Water (2–3 liters) – Dehydration is common, especially in summer.

Snacks – Energy bars, dry fruits, or glucose for quick boosts.

Rain Gear – Poncho/raincoat (especially during monsoon treks).

Torch/Headlamp – Trails can get dark earlier than expected.

First Aid Kit – Band-aids, antiseptic, ORS, pain relievers.

Power Bank – For mobile/GPS, in case of emergency.

⚠️ Precautions to Take

Weather Check – Nashik treks are risky during heavy monsoon due to slippery rocks and landslide chances.

Travel in Groups – Many routes are isolated; having a group increases safety.

Inform Someone – Share your trek plan and expected return time.

Local Guide – For tougher treks like Harihar, hiring a local guide is strongly recommended.

Avoid Night Treks – Visibility is low and wild animal movement increases.

Emergency Contacts – Save Nashik rescue helplines and nearest hospital details.

🛡️ Risk Zone Classification (for Alerts)

To integrate with your geofencing system, the trek routes around Nashik can be classified into risk zones based on difficulty, terrain, and safety infrastructure:

🟢 Low Risk Zone (Beginner-Friendly)

Well-marked trails with moderate incline.

Example: Anjneri Hills base trail.

Safe for families and beginners with basic gear.

🟡 Moderate Risk Zone (Intermediate)

Steeper climbs, some rocky or forested patches.

Example: Brahmagiri trek.

Caution advised in monsoon; suitable for fit trekkers.

🔴 High Risk Zone (Advanced/Dangerous)

Very steep rock-cut steps, exposed ridges, or narrow paths.

Example: Harihar Fort trek.

Risk of falls, slips, or altitude fatigue. Not recommended for beginners.

🌍 Final Thoughts

A trek in Nashik isn't just about adventure—it's about respecting nature and knowing your limits. With the right preparation and awareness of risk zones, you can enjoy panoramic views, historic forts, and serene landscapes while staying safe.

So pack smart, trek responsibly, and let your journey through Nashik's rugged trails be a memory you'll cherish for life.''',
    category: 'Adventure',
    author: 'Adventure Guide Team',
    date: 'Sep 13, 2025',
    readTime: '8 min read',
    imageAsset: 'assets/mountain.jpg',
    isFeatured: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildFeaturedBlog(),
                SizedBox(height: 24),
                _buildCategoryChips(),
                SizedBox(height: 24),
                Text(
                  'Latest Blogs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                _buildTrekkingBlogCard(),
                _buildKyotoTempleBlogCard(),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add search functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Search coming soon!')),
          );
        },
        backgroundColor: Color(0xFF0284C7),
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Color(0xFF0284C7),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Travel Blogs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/travel.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBlog() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/travel1.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF0284C7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discovering Hidden Gems in Bali',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '5 min read',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.calendar_today,
                          color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Sep 13, 2025',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      'All',
      'Adventure',
      'Culture',
      'Food',
      'Nature',
      'City Life',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(category),
              backgroundColor:
                  category == 'All' ? Color(0xFF0284C7) : Colors.grey[200],
              labelStyle: TextStyle(
                color: category == 'All' ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {},
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTrekkingBlogCard() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailPage(blog: trekkingBlog),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/mountain.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Adventure',
                            style: TextStyle(
                              color: Color(0xFF0284C7),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.bookmark_border, color: Color(0xFF0284C7)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Trekking at Nashik: An Adventurer\'s Guide',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover Maharashtra\'s most scenic trekking routes with essential tips, safety guidelines, and risk zone classifications...',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFF0284C7).withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 20,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Adventure Guide Team',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time,
                            color: Colors.black54, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '8 min read',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKyotoTempleBlogCard() {
    final kyotoTempleBlog = BlogPost(
      title: 'Traditional Temples of Kyoto',
      content:
          '''Explore the ancient temples and shrines that make Kyoto one of Japan's most beautiful cities. From the golden pavilion of Kinkaku-ji to the serene rock gardens of Ryoan-ji, each temple tells a unique story of Japan's rich cultural heritage.

🏯 Must-Visit Temples

Kinkaku-ji (Golden Pavilion)
- Famous for its gold-leaf covered exterior
- Surrounded by a stunning mirror pond
- Best visited in early morning or late afternoon

Fushimi Inari Shrine
- Thousands of vibrant torii gates
- Sacred to Inari, the god of rice and sake
- Amazing hiking trails through the mountain

Kiyomizu-dera
- UNESCO World Heritage site
- Famous wooden terrace with city views
- Beautiful cherry blossoms in spring

📸 Photography Tips

- Golden hour lighting (sunrise/sunset)
- Use wide-angle lens for architecture
- Respect no-photo zones in sacred areas
- Consider tripod for low-light interiors

🎎 Cultural Etiquette

- Remove shoes when entering temples
- Speak quietly and respectfully
- Follow designated paths
- Make a small donation when praying

⏰ Best Times to Visit

- Early morning: Fewer crowds
- Spring: Cherry blossoms
- Fall: Autumn colors
- Winter: Snow-covered temples

Whether you're a history enthusiast, photographer, or spiritual seeker, Kyoto's temples offer a profound glimpse into Japanese culture and architecture. Take your time, observe the details, and let the peaceful atmosphere transport you to another time.''',
      category: 'Culture',
      author: 'Sarah Parker',
      date: 'Sep 12, 2025',
      readTime: '5 min read',
      imageAsset: 'assets/temple.jpg',
      isFeatured: false,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailPage(blog: kyotoTempleBlog),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/temple.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Culture',
                            style: TextStyle(
                              color: Color(0xFF0284C7),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.bookmark_border, color: Color(0xFF0284C7)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Traditional Temples of Kyoto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore the ancient temples and shrines that make Kyoto one of Japan\'s most beautiful cities...',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFF0284C7).withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 20,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sarah Parker',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time,
                            color: Colors.black54, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '5 min read',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
