import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/view/widgets/markdown_editor_plus/widgets/markdown_parse_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

// Colored hashtag syntax
class ColoredHashtagSyntax extends md.InlineSyntax {
  ColoredHashtagSyntax({String pattern = r'#[^\s#]+'}) : super(pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final tag = match.group(0).toString();
    md.Element hashtagElement = md.Element.text("hashtag", tag);
    parser.addNode(hashtagElement);
    return true;
  }
}

// hashtag element builder
class ColoredHashtagElementBuilder extends MarkdownElementBuilder {
  final MarkdownTapTagCallback? onTapHashtag;

  ColoredHashtagElementBuilder(this.onTapHashtag);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return GestureDetector(
      onTap: () {
        onTapHashtag?.call(
          element.textContent.replaceFirst("#", ""),
          element.textContent,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: midnightBlue.withOpacity(0.1),
        ),
        child: Text(
          '${element.textContent}',
          style: TextStyle(
            color: midnightBlue,
          ),
        ),
      ),
    );
  }
}

// Colored mention syntax
class ColoredMentionSyntax extends md.InlineSyntax {
  ColoredMentionSyntax({String pattern = r'\@[^\s@]+'}) : super(pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final tag = match.group(0).toString();
    md.Element mentionElement = md.Element.text("mention", tag);
    parser.addNode(mentionElement);
    return true;
  }
}

// mention element builder
class ColoredMentionElementBuilder extends MarkdownElementBuilder {
  final MarkdownTapTagCallback? onTapMentions;

  ColoredMentionElementBuilder(this.onTapMentions);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return GestureDetector(
      onTap: () {
        onTapMentions?.call(
          element.textContent.replaceFirst("@", ""),
          element.textContent,
        );
      },
      child: Text(
        "${element.textContent} ",
        style: TextStyle(
          color: midnightBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
