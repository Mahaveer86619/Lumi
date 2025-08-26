abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {

  // final InternetConnection internetConnection;
  // ConnectionCheckerImpl(this.internetConnection);

  // @override
  // Future<bool> get isConnected async =>
  //     await internetConnection.hasInternetAccess;

  @override
  Future<bool> get isConnected => throw UnimplementedError();
}