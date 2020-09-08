import 'package:da_muasachonline/data/spref/spref.dart';
import 'package:da_muasachonline/shared/constant.dart';
import 'package:dio/dio.dart';

class BookClient {
  // ios localhost:
  static BaseOptions _options = new BaseOptions(
    baseUrl: "35.224.16.221:8000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio = Dio(_options);

  BookClient._internal() {
//    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return myOption;
    }));
  }
  static final BookClient instance = BookClient._internal();

  Dio get dio => _dio;
}
