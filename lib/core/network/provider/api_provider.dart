// lib/core/providers/api_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dio_client.dart';

/// Provide ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

