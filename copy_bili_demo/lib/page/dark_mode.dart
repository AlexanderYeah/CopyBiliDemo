import 'package:copy_bili_demo/provider/theme_provider.dart';
import 'package:copy_bili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({super.key});

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _items = [
    {"name": "跟随系统", "mode": ThemeMode.system},
    {"name": "开启", "mode": ThemeMode.dark},
    {"name": "关闭", "mode": ThemeMode.light},
  ];
  // 当前的主题
  var _currentTheme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var themeMode = context.read<ThemeProvider>().getThemeMode();
    _items.forEach((element) {
      if (element["mode"] == themeMode) {
        _currentTheme = element["mode"];
      }
    });
    print(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置主题"),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            return _buildItem(index);
          }),
          separatorBuilder: ((context, index) {
            return Divider();
          }),
          itemCount: _items.length),
    );
  }

  _buildItem(index) {
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左边标题
            Text(_items[index]["name"] as String),
            // 右边打钩
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Opacity(
                opacity: _currentTheme == _items[index]["mode"] ? 1 : 0,
                child: Icon(
                  Icons.done,
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _switchTheme(index) {
    ThemeMode themeMode = _items[index]["mode"] as ThemeMode;
    print(themeMode);
    context.read<ThemeProvider>().setTheme(themeMode);
    setState(() {
      _currentTheme = themeMode;
      print(_currentTheme);
    });
  }
}
