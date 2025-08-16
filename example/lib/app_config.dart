import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String powerfrontDomainUrl = dotenv.get('DOMAIN_URL', fallback: '');
  static String powerfrontAccountKey = dotenv.get('ACCOUNT_KEY', fallback: '');
  static String powerfrontAppName = dotenv.get('APP_NAME', fallback: '');
  static String powerfrontMobileSiteUrl = dotenv.get('MOBILE_SITE_URL', fallback: '');
}
