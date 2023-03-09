import 'package:shared_preferences/shared_preferences.dart';

class SKCache {
  SharedPreferences? prefs;

  SKCache() {
    init();
  }

  static SKCache? _instance;

  static SKCache getInstance() {
    if (_instance == null) {
      _instance = SKCache();
    }
    return _instance!;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  // 预初始化操作 防止在使用get的时候 prefs 还未完成初始化
  static Future<SKCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = SKCache._pre(prefs);
    }
    return _instance!;
  }

  SKCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  setString(String key, String value) {
    prefs!.setString(key, value);
  }

  setInt(String key, int value) {
    prefs!.setInt(key, value);
  }

  setDouble(String key, double value) {
    prefs!.setDouble(key, value);
  }

  setBool(String key, bool value) {
    prefs!.setBool(key, value);
  }

  setList(String key, List<String> value) {
    prefs!.setStringList(key, value);
  }

  // 泛型的方式获取数据
  Object? get<T>(String key) {
    return prefs!.get(key);
  }
}
