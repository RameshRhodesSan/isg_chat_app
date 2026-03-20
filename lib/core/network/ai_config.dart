class AiConfig {
  AiConfig._();

  static const String baseUrl = 'https://api.openai.com/v1';
  static const String chatEndpoint = '$baseUrl/chat/completions';
  static const String model = 'gpt-3.5-turbo';
  static const String systemPrompt =
      'You are ISG Chat, a helpful and concise AI assistant. '
      'Answer clearly and directly.';
  static const int maxTokens = 1024;
  static const double temperature = 0.7;
}
