import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GradScaffold(
      child: Column(
       
        children: [
          /// TOP BAR
          SarthiTopBar(title: article.tag),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICON
                  Container(
                    width: width * 0.18,
                    height: width * 0.18,
                    decoration: BoxDecoration(
                      color: SC.lavLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        article.icon,
                        style: TextStyle(fontSize: width * 0.08),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// TITLE
                  Text(
                    article.title,
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: SC.purpleDark,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  /// READ TIME
                  SarthiBadge(
                    label: '📖 ${article.readTime} read',
                    color: SC.textMuted,
                  ),

                  SizedBox(height: height * 0.02),

                  Divider(color: SC.lavender),

                  SizedBox(height: height * 0.02),

                  /// ARTICLE BODY
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: article.body.split('\n').map((line) {
                      final text = line.trim();

                      if (text.isEmpty) {
                        return SizedBox(height: height * 0.01);
                      }

                      /// Heading (# )
                      if (text.startsWith('# ')) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.015),
                          child: Text(
                            text.replaceFirst('# ', ''),
                            style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                              color: SC.purpleDark,
                            ),
                          ),
                        );
                      }

                      /// Subheading (## )
                      if (text.startsWith('## ')) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.012),
                          child: Text(
                            text.replaceFirst('## ', ''),
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: SC.purpleDark,
                            ),
                          ),
                        );
                      }

                      /// Bullet point (- or •)
                      if (text.startsWith('- ') || text.startsWith('• ')) {
                        final content = text.substring(2).trim();
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: height * 0.008,
                                  right: width * 0.02,
                                ),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: SC.purple,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  content,
                                  style: TextStyle(
                                    fontSize: width * 0.038,
                                    color: SC.textDark,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      /// Numbered list (1. 2. 3.)
                      final numMatch =
                          RegExp(r'^(\d+)\.\s+(.+)$').firstMatch(text);
                      if (numMatch != null) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                margin: EdgeInsets.only(
                                  top: 2,
                                  right: width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: SC.purple.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    numMatch.group(1)!,
                                    style: TextStyle(
                                      fontSize: width * 0.028,
                                      fontWeight: FontWeight.w900,
                                      color: SC.purple,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  numMatch.group(2)!,
                                  style: TextStyle(
                                    fontSize: width * 0.038,
                                    color: SC.textDark,
                                    height: 1.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      /// Normal paragraph
                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.015),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: width * 0.038,
                            color: SC.textDark,
                            height: 1.9,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
