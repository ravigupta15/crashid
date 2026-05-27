import 'package:html/parser.dart' as html_parser;

/// Utility class for extracting plain text from HTML content
class HtmlTextExtractor {
  /// Extracts plain text from HTML string
  /// 
  /// Removes all HTML tags and returns only the text content.
  /// Optionally normalizes whitespace.
  static String extractText(
    String htmlContent, {
    bool normalizeWhitespace = true,
  }) {
    try {
      final document = html_parser.parse(htmlContent);
      final text = document.body?.text ?? '';
      
      if (normalizeWhitespace) {
        // Replace multiple spaces/newlines with single space
        return text
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();
      }
      return text;
    } catch (e) {
      return htmlContent;
    }
  }

  /// Extracts text and limits to a maximum length with ellipsis
  static String extractTextWithLimit(
    String htmlContent, {
    int maxLength = 100,
    String ellipsis = '...',
    bool normalizeWhitespace = true,
  }) {
    final text = extractText(
      htmlContent,
      normalizeWhitespace: normalizeWhitespace,
    );
    
    if (text.length <= maxLength) {
      return text;
    }
    
    return text.substring(0, maxLength) + ellipsis;
  }

  /// Extracts text and splits by lines
  static List<String> extractLines(String htmlContent) {
    try {
      final document = html_parser.parse(htmlContent);
      final text = document.body?.text ?? '';
      return text
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.trim())
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Extracts specific text from HTML by tag
  static List<String> extractTextByTag(String htmlContent, String tag) {
    try {
      final document = html_parser.parse(htmlContent);
      final elements = document.getElementsByTagName(tag);
      return elements.map((el) => el.text).toList();
    } catch (e) {
      return [];
    }
  }
}
