import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<ConnectivityResult> get connectionType;
  Stream<ConnectivityResult> get onConnectivityChanged;
  Future<bool> get hasInternetAccess;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker internetConnectionChecker;
  
  NetworkInfoImpl({
    required this.connectivity,
    required this.internetConnectionChecker,
  });
  
  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
  
  @override
  Future<ConnectivityResult> get connectionType async {
    return await connectivity.checkConnectivity();
  }
  
  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return connectivity.onConnectivityChanged;
  }
  
  @override
  Future<bool> get hasInternetAccess async {
    try {
      final isConnected = await this.isConnected;
      if (!isConnected) return false;
      
      return await internetConnectionChecker.hasConnection;
    } catch (e) {
      return false;
    }
  }
}