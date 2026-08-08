abstract interface class CacheStore {
  String? read(String key);
  void write(String key, String value);
  void remove(String key);
}

class InMemoryCacheStore implements CacheStore {
  final Map<String, String> _values = <String, String>{};

  @override
  String? read(String key) => _values[key];

  @override
  void remove(String key) {
    _values.remove(key);
  }

  @override
  void write(String key, String value) {
    _values[key] = value;
  }
}
