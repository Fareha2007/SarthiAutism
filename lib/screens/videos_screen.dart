// ============================================================
//  SARTHI — Videos Screen (Updated)
//  - Shimmer loading effect
//  - Cached thumbnails (faster load)
//  - Opens YouTube app via url_launcher (no WebView conflict)
//  - Firebase Firestore as data source
//
//  pubspec.yaml dependencies needed:
//    cloud_firestore: ^5.6.12
//    cached_network_image: ^3.3.0
//    url_launcher: ^6.3.0
//    shimmer: ^3.0.0
// ============================================================

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

// ── Colors ────────────────────────────────────────────────────────────────────
const _purple = Color(0xFF8B5BA6);
const _purpleDark = Color(0xFF5C3578);
const _lavLight = Color(0xFFF3EEFF);
const _lavender = Color(0xFFD9B8FF);
const _mintDark = Color(0xFF3A9E74);
const _border = Color(0xFFE0D4F0);
const _bgAlt = Color(0xFFF0EBF9);
const _textDark = Color(0xFF2A1A3E);
const _textMuted = Color(0xFF8A7A9A);
const _gradTop = Color(0xFFB4E2FC);
const _gradMid = Color(0xFFF2EFE6);
const _gradBot = Color(0xFFE8D5F2);
const _skyDark = Color(0xFF5A8FD4);
const _amber = Color(0xFFE8A830);

// ── Video Model ───────────────────────────────────────────────────────────────
class VideoItem {
  final String id;
  final String title;
  final String description;
  final String videoId;
  final String category;
  final String duration;
  final String channel;
  final int order;

  String get thumbnail => 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

  const VideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.videoId,
    required this.category,
    required this.duration,
    required this.channel,
    required this.order,
  });

  static String _clean(String? val) =>
      (val ?? '').trim().replaceAll(RegExp(r'^"+|"+$'), '');

  factory VideoItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final cat = _clean(data['category'] as String?);
    return VideoItem(
      id: doc.id,
      title: _clean(data['title'] as String?),
      description: _clean(data['description'] as String?),
      videoId: _clean(data['videoId'] as String?),
      category: cat.isEmpty ? 'Awareness' : cat,
      duration: _clean(data['duration'] as String?),
      channel: _clean(data['channel'] as String?),
      order: (data['order'] is int)
          ? data['order'] as int
          : (data['order'] is double)
              ? (data['order'] as double).toInt()
              : int.tryParse(data['order']?.toString() ?? '0') ?? 0,
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  VIDEOS SCREEN
// ─────────────────────────────────────────────────────────────
class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Awareness',
    'Therapy',
    'Govt. Schemes',
    'Stories',
  ];

  Color _categoryColor(String cat) {
    switch (cat) {
      case 'Awareness':
        return _purple;
      case 'Therapy':
        return _skyDark;
      case 'Govt. Schemes':
        return _mintDark;
      case 'Stories':
        return _amber;
      default:
        return _purple;
    }
  }

  String _categoryIcon(String cat) {
    switch (cat) {
      case 'Awareness':
        return '🧩';
      case 'Therapy':
        return '🎯';
      case 'Govt. Schemes':
        return '🏛️';
      case 'Stories':
        return '💛';
      default:
        return '▶️';
    }
  }

  // Opens YouTube app, falls back to browser
  Future<void> _openVideo(String videoId) async {
    final appUrl = Uri.parse('youtube://www.youtube.com/watch?v=$videoId');
    final webUrl = Uri.parse('https://www.youtube.com/watch?v=$videoId');

    try {
      if (await canLaunchUrl(appUrl)) {
        await launchUrl(appUrl);
      } else {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.61, 1.0],
            colors: [_gradTop, _gradMid, _gradBot],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              _buildCategoryFilter(),
              Expanded(child: _buildVideoList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _border),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: _purpleDark),
            ),
          ),
          const Spacer(),
          const Text(
            'Videos',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: _purpleDark,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 0, 10),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          itemBuilder: (_, i) {
            final cat = _categories[i];
            final selected = _selectedCategory == cat;
            final color = cat == 'All' ? _purple : _categoryColor(cat);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? color : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: selected ? color : _border,
                      width: 1.5,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                                color: color.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ]
                        : [],
                  ),
                  child: Text(
                    cat == 'All' ? '✨ All' : '${_categoryIcon(cat)} $cat',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : _textMuted,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('videos')
          .orderBy('order')
          .snapshots(),
      builder: (context, snapshot) {
        // ── Shimmer while loading ───────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            itemCount: 3,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: _ShimmerCard(),
            ),
          );
        }

        // ── Error ───────────────────────────────────────────
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('😕', style: TextStyle(fontSize: 48)),
                SizedBox(height: 12),
                Text(
                  'Could not load videos.\nCheck your connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textMuted, fontSize: 14),
                ),
              ],
            ),
          );
        }

        // ── Empty ───────────────────────────────────────────
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        // ── Parse + filter ──────────────────────────────────
        final allVideos = snapshot.data!.docs
            .map((doc) => VideoItem.fromFirestore(doc))
            .where((v) => v.videoId.isNotEmpty)
            .toList();

        final filtered = _selectedCategory == 'All'
            ? allVideos
            : allVideos.where((v) => v.category == _selectedCategory).toList();

        if (filtered.isEmpty) return _buildEmptyState();

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          itemCount: filtered.length,
          itemBuilder: (ctx, i) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _VideoCard(
              video: filtered[i],
              categoryColor: _categoryColor(filtered[i].category),
              categoryIcon: _categoryIcon(filtered[i].category),
              onTap: () => _openVideo(filtered[i].videoId),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🎬', style: TextStyle(fontSize: 52)),
          SizedBox(height: 16),
          Text(
            'No videos yet',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
              color: _purpleDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Videos will appear here once\nadded by the admin.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: _textMuted, height: 1.6),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SHIMMER LOADING CARD
// ─────────────────────────────────────────────────────────────
class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail placeholder
            Container(
              width: double.infinity,
              height: 190,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity, height: 16, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(width: 200, height: 14, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(width: 120, height: 12, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  VIDEO CARD
// ─────────────────────────────────────────────────────────────
class _VideoCard extends StatelessWidget {
  final VideoItem video;
  final Color categoryColor;
  final String categoryIcon;
  final VoidCallback onTap;

  const _VideoCard({
    required this.video,
    required this.categoryColor,
    required this.categoryIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _border),
          boxShadow: [
            BoxShadow(
              color: _purple.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ──────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  child: CachedNetworkImage(
                    imageUrl: video.thumbnail,
                    width: double.infinity,
                    height: 195,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade50,
                      child: Container(
                        width: double.infinity,
                        height: 195,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 195,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            categoryColor.withOpacity(0.3),
                            categoryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18)),
                      ),
                      child: const Center(
                        child: Text('🎬', style: TextStyle(fontSize: 52)),
                      ),
                    ),
                  ),
                ),

                // Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(18)),
                    ),
                  ),
                ),

                // Play button
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                          color: categoryColor, size: 36),
                    ),
                  ),
                ),

                // Duration
                if (video.duration.isNotEmpty)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.72),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        video.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                // Category badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$categoryIcon ${video.category}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Info ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (video.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      video.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _textMuted,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(categoryIcon,
                              style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          video.channel,
                          style: TextStyle(
                            fontSize: 12,
                            color: categoryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: categoryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_circle_outline_rounded,
                                color: categoryColor, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              'Watch',
                              style: TextStyle(
                                fontSize: 12,
                                color: categoryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
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
}
