import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_button.dart';

enum OtpPurpose { registration, forgotPassword }

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final OtpPurpose purpose;

  OtpVerificationPage({
    required this.email,
    required this.purpose,
  });

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response =
          await ApiService.verifyOtp(_otpController.text.trim(), widget.email);

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        // OTP xác thực thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xác thực OTP thành công')),
        );

        if (widget.purpose == OtpPurpose.forgotPassword) {
          // Chuyển đến trang đặt lại mật khẩu
          Navigator.pushReplacementNamed(
            context,
            '/reset_password',
            arguments: {'email': widget.email},
          );
        } else {
          // Chuyển về trang đăng nhập
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Đã xảy ra lỗi: $e';
      });
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await ApiService.sendOtpMail(widget.email);

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã gửi lại mã OTP thành công')),
        );
      } else {
        setState(() {
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Đã xảy ra lỗi: $e';
      });
    }
  }

  String _getTitle() {
    return widget.purpose == OtpPurpose.registration
        ? 'Xác Thực Đăng Ký'
        : 'Xác Thực Quên Mật Khẩu';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Text(
                  'Nhập Mã OTP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Chúng tôi đã gửi mã xác thực đến email ${widget.email}',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mã OTP',
                    hintText: 'Nhập mã OTP 6 chữ số',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã OTP';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 24),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Xác Nhận',
                        onPressed: _verifyOtp,
                      ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Không nhận được mã? '),
                    TextButton(
                      onPressed: _resendOtp,
                      child: Text('Gửi lại mã OTP'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
