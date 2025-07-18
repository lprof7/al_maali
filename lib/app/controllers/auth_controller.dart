import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthController extends GetxController {
  // حالة المستخدم: هل هو مسجل الدخول أم لا
  final RxBool isLoggedIn = false.obs;

  // بيانات المستخدم (مؤقتة)
  String? userName;
  String? userEmail;
  UserModel? currentUser;

  // تسجيل الدخول
  Future<String?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني وكلمة المرور';
    }
    // 1. تحقق من التخزين المحلي
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      final userJson = json.decode(userString);
      final user = UserModel.fromJson(userJson);
      if (user.email == email && user.password == password) {
        isLoggedIn.value = true;
        currentUser = user;
        return null;
      }
    }
    // 2. إذا لم يوجد محلياً، أرسل طلب HTTP
    try {
      final response = await http.post(
        Uri.parse('URL'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final user = UserModel.fromJson(data['user']);
          await prefs.setString('user', json.encode(user.toJson()));
          isLoggedIn.value = true;
          currentUser = user;
          return null;
        } else {
          return data['message'] ?? 'فشل تسجيل الدخول';
        }
      } else {
        return 'خطأ في الاتصال بالخادم';
      }
    } catch (e) {
      return 'حدث خطأ أثناء الاتصال: $e';
    }
  }

  // إنشاء حساب
  Future<String?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'يرجى ملء جميع الحقول';
    }
    if (password != confirmPassword) {
      return 'كلمتا المرور غير متطابقتين';
    }
    // مثال: إرسال بيانات التسجيل إلى السيرفر (يمكنك تعديل الرابط والمنطق حسب الحاجة)
    try {
      final response = await http.post(
        Uri.parse('URL'),
        body: {'name': name, 'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          print(data);
          final user = UserModel.fromJson(data['user']);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', json.encode(user.toJson()));
          isLoggedIn.value = true;
          currentUser = user;
          return null;
        } else {
          return data['message'] ?? 'فشل إنشاء الحساب';
        }
      } else {
        return 'خطأ في الاتصال بالخادم';
      }
    } catch (e) {
      return 'حدث خطأ أثناء الاتصال: $e';
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    isLoggedIn.value = false;
    currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
