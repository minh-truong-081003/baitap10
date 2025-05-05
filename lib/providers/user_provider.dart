import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Tải thông tin người dùng từ SharedPreferences
  Future<bool> loadUserFromStorage() async {
    setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(Constants.userDataKey);
      
      if (userData != null) {
        final Map<String, dynamic> userMap = jsonDecode(userData);
        _user = UserModel.fromJson(userMap);
        setLoading(false);
        notifyListeners();
        return true;
      }
      
      setLoading(false);
      return false;
    } catch (e) {
      setLoading(false);
      setErrorMessage('Lỗi khi tải thông tin người dùng: $e');
      return false;
    }
  }

  // Lưu thông tin người dùng vào SharedPreferences
  Future<void> saveUserToStorage(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.userDataKey, jsonEncode(user.toJson()));
      await prefs.setString(Constants.userIdKey, user.id ?? '');
    } catch (e) {
      setErrorMessage('Lỗi khi lưu thông tin người dùng: $e');
    }
  }

  // Cập nhật thông tin người dùng hiện tại
  void setUser(UserModel user) {
    _user = user;
    saveUserToStorage(user);
    notifyListeners();
  }

  // Đăng xuất
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(Constants.userDataKey);
      await prefs.remove(Constants.userIdKey);
      await prefs.remove(Constants.userTokenKey);
      _user = null;
      notifyListeners();
    } catch (e) {
      setErrorMessage('Lỗi khi đăng xuất: $e');
    }
  }
} 