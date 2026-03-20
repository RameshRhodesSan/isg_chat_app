import 'package:isg_chat_app/core/constants/app_constants.dart';
import 'package:isg_chat_app/core/utils/app_logger.dart';
import 'package:isg_chat_app/data/sources/remote/firestore_service.dart';

/// Fetches the OpenAI API key from Firestore `config/openai`.
/// Caches the key in memory after the first successful fetch.
class AiConfigService {
  AiConfigService({required FirestoreService firestoreService})
      : _firestore = firestoreService;

  final FirestoreService _firestore;
  String? _cachedApiKey;

  /// Returns the API key. Reads from cache after the first call.
  Future<String> getApiKey() async {
    if (_cachedApiKey != null) return _cachedApiKey!;

    final data = await _firestore.getDocument(
      collection: AppConstants.configCollection,
      docId: AppConstants.configOpenAiDoc,
    );

    final key = data?[AppConstants.fieldApiKey] as String?;

    if (key == null || key.isEmpty) {
      AppLogger.instance.e('AiConfigService: apiKey missing in config/openai');
      throw Exception('AI API key not configured in Firestore.');
    }

    _cachedApiKey = key;
    AppLogger.instance.i('AiConfigService: API key loaded from Firestore.');
    return _cachedApiKey!;
  }

  /// Clears the cache — forces a fresh Firestore read on the next call.
  void invalidate() => _cachedApiKey = null;
}

