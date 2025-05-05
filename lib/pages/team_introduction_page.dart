import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_page.dart';
import 'home_page.dart';

class TeamIntroductionPage extends StatefulWidget {
  @override
  _TeamIntroductionPageState createState() => _TeamIntroductionPageState();
}

class _TeamIntroductionPageState extends State<TeamIntroductionPage> {
  @override
  void initState() {
    super.initState();
    // Kiểm tra trạng thái đăng nhập sau 1 giây
    Future.delayed(Duration(seconds: 1), () {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isLoggedIn = await userProvider.loadUserFromStorage();

    // Sau 3 giây nữa sẽ chuyển trang
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        // Nếu đã đăng nhập thì vào trang chủ
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Nếu chưa đăng nhập thì vào trang đăng nhập
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giới thiệu Nhóm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chào mừng đến với Nhóm Phát Triển!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Thành viên:\n- Thành viên 1: Nguyễn Minh Trường\n- Thành viên 2: Nguyễn Huỳnh Duy Tân\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
