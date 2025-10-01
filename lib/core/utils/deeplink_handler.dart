import 'package:famproject/core/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class DeeplinkHandler {
  static Future<void> handleUrl(String? url) async {
     if (url == null || url.isEmpty) {
       return;
     }
     try{
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        logInfo('Could not launch URL: $url');
     }} catch (e) {
      logError('Error launching URL: $url', e);
    }
  }
}
