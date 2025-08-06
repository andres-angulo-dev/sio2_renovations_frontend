// Conditional import based on the platform
export '../services/inject_google_maps_script_mobile_service.dart'
  if (dart.library.js_interop) '../services/inject_google_maps_script_web_service.dart';
