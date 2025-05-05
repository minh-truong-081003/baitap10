# Ứng dụng Quản lý Bán hàng

Ứng dụng Flutter để quản lý bán hàng với các tính năng đăng ký, đăng nhập và quên mật khẩu.

## Cài đặt

1. Đảm bảo bạn đã cài đặt [Flutter](https://flutter.dev/docs/get-started/install)
2. Clone repository này
3. Chạy `flutter pub get` để cài đặt các dependencies

## Cấu hình

1. Đảm bảo máy chủ Node.js đã được chạy (từ thư mục Server)
2. Cập nhật URL API trong `lib/utils/constants.dart` nếu cần thiết

### Cấu hình cho Android

Mặc định, URL API được cấu hình cho Android Emulator là `http://10.0.2.2:3000/api`. Nếu bạn đang chạy trên thiết bị thực, hãy thay đổi thành địa chỉ IP của máy chủ.

### Cấu hình cho iOS

Nếu bạn đang chạy trên iOS Simulator, URL API nên là `http://localhost:3000/api`.

## Chạy ứng dụng

```bash
# Chạy ứng dụng trong chế độ debug
flutter run

# Tạo bản build cho Android
flutter build apk

# Tạo bản build cho iOS
flutter build ios
```

## Tính năng

- Đăng nhập/Đăng ký
- Xác thực với OTP qua email
- Quên mật khẩu
- Trang chủ với thông tin người dùng
- Quản lý phiên đăng nhập với SharedPreferences

## Cấu trúc dự án

- `lib/`
  - `main.dart` - Điểm khởi đầu của ứng dụng
  - `models/` - Các model dữ liệu
  - `pages/` - Các màn hình UI
  - `providers/` - State management với Provider
  - `services/` - Các dịch vụ API
  - `utils/` - Các tiện ích, hằng số
  - `widgets/` - Các widget tái sử dụng


## cách chạy với máy  thật
1. Đảm bảo bạn đã kết nối với máy thật. kiểm tra bằng lệnh: 
    adb devices trong terminal
2. chạy cách lệnh sau:
    cd Server
    npm install
    npm run server
3. setup 3th để hỗ trợ api.
  đảm bảo bạn đã cài đặt ngrok
  ngrok http://localhost:3000
  sau đó copy địa chỉ url và gán vào file banhang_manager\lib\services\api_service.dart
4. tiến hành run code:
    flutter run

