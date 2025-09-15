import 'package:web/web.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void injectGoogleMapsScript() {
  final googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  if (googleMapsApiKey == null) {
    return;
  }
  
  // Check if the script is already present
  final existingScript = document.querySelector('script[src*="maps.googleapis.com/maps/api/js"]');
  if (existingScript != null) return;

  final script = HTMLScriptElement()
    ..src = 'https://maps.googleapis.com/maps/api/js?key=$googleMapsApiKey&loading=async&libraries=marker'
    ..async = true
    ..defer = true;
  document.body!.append(script);
}
