import 'package:flutter/material.dart';
import '../services/article_service.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../data/static_data.dart';
import 'article_screen.dart';
import 'scheme_detail_screen.dart';
import '../models/models.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _articlesFuture = ArticleService.fetchArticles();
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    setState(() {
      _articlesFuture = ArticleService.fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Learn', showBack: false),

          // ── Tab bar ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: SC.bgAlt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tab,
                indicator: BoxDecoration(
                  color: SC.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: SC.textMuted,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: '🏛️  Govt. Schemes'),
                  Tab(text: '📖  Articles'),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                // ══════════════════════════════════════════════
                // SCHEMES TAB — static data
                // ══════════════════════════════════════════════
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  itemCount: kSchemes.length + 1,
                  itemBuilder: (ctx, i) {
                    if (i == kSchemes.length) return _helplineCard();
                    final s = kSchemes[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: SarthiCard(
                        onTap: () => Navigator.push(
                          ctx,
                          slideRoute(SchemeDetailScreen(scheme: s)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: SC.lavLight,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Icon(Icons.badge_rounded,
                                    size: 26, color: SC.purple),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.name,
                                      style: const TextStyle(
                                        fontFamily: 'PlayfairDisplay',
                                        fontSize: 16,
                                        color: SC.purpleDark,
                                      )),
                                  const SizedBox(height: 2),
                                  Text(s.ministry,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: SC.purple,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  const SizedBox(height: 8),
                                  SarthiBadge(
                                    label: '✅ ${s.eligibility}',
                                    color: SC.green,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded,
                                color: SC.textMuted),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // ══════════════════════════════════════════════
                // ARTICLES TAB — live from ArticleService
                // ══════════════════════════════════════════════
                FutureBuilder<List<Article>>(
                  future: _articlesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const _LoadingShimmer();
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return _ErrorView(onRetry: _refresh);
                    }

                    final articles = snapshot.data!;

                    return RefreshIndicator(
                      color: SC.purple,
                      onRefresh: _refresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        itemCount: articles.length,
                        itemBuilder: (ctx, i) {
                          final a = articles[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SarthiCard(
                              onTap: () => Navigator.push(
                                ctx,
                                slideRoute(ArticleScreen(article: a)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: SC.lavLight,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Center(
                                      child: Text(a.icon,
                                          style:
                                              const TextStyle(fontSize: 26)),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(a.title,
                                            style: const TextStyle(
                                              fontFamily: 'PlayfairDisplay',
                                              fontSize: 15,
                                              color: SC.purpleDark,
                                            )),
                                        const SizedBox(height: 6),
                                        Wrap(spacing: 6, children: [
                                          SarthiBadge(
                                              label: a.tag, color: SC.purple),
                                          SarthiBadge(
                                              label: '📖 ${a.readTime}',
                                              color: SC.textMuted),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_rounded,
                                      color: SC.textMuted),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _helplineCard() => SarthiCard(
        color: SC.lavLight,
        border: Border.all(color: SC.lavender),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📞 National Disability Helpline',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 16,
                  color: SC.purpleDark,
                )),
            SizedBox(height: 6),
            Text('1800-11-4515',
                style: TextStyle(
                  fontSize: 18,
                  color: SC.purple,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(height: 4),
            Text('Toll-free · Monday to Saturday · 9 AM – 5 PM',
                style: TextStyle(fontSize: 12, color: SC.textMuted)),
          ],
        ),
      );
}

// ══════════════════════════════════════════════════════════════
//  SHIMMER LOADING
// ══════════════════════════════════════════════════════════════
class _LoadingShimmer extends StatefulWidget {
  const _LoadingShimmer();

  @override
  State<_LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<_LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final color = Color.lerp(
          const Color(0xFFEDE7F6),
          const Color(0xFFD1C4E9),
          _anim.value,
        )!;
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          itemCount: 5,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 13,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 100,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  ERROR VIEW
// ══════════════════════════════════════════════════════════════
class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('😕', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            const Text('Could not load articles',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 18,
                  color: SC.purpleDark,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: 8),
            const Text(
              'Check your internet connection\nand try again.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 13, color: SC.textMuted, height: 1.55),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: SC.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Retry',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}