import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum selectedPage {
  home,
  map,
  profile,
  settings,
  messages,
  sos,
  permissionRationale
}
enum loading { started, finished }
enum authenticationStage {
  authenticateEmail,
  verifyPhoneNumber,
  resendCode,
  forgotPassword,
  verifyCode,
  authenticated
}

enum timerState { show, hide }

enum sosButtonState { show, hide }

class AppStateProvider with ChangeNotifier {
  AppStateProvider({this.deviceLocal, this.sharedPreferences});

  String deviceLocal;
  SharedPreferences sharedPreferences;
  AppLifecycleState _lifeCycleState = AppLifecycleState.resumed;
  var _selectedPage = selectedPage.home;
  var _timerState = timerState.hide;
  var _authenticationStage = authenticationStage.authenticateEmail;
  int _notificationsCount = 0;
  var _sosButtonState = sosButtonState.show;
  String _phoneNumber;
  String _authResult;

  var _loadingStatus = loading.finished;

  getLoadingStatus() => _loadingStatus;

  setLoading(loading) {
    _loadingStatus = loading;
    notifyListeners();
  }

  int getNotificationsCount() => _notificationsCount.toInt();

  getAppLifeCycleState() => _lifeCycleState;

  setAppLifeCycleState(state) {
    _lifeCycleState = state;
  }

  setNotificationsCount(int count) {
    _notificationsCount = count;
    notifyListeners();
  }

  incrementNotificationsCount() {
    _notificationsCount++;
    notifyListeners();
  }

  getTimerState() => _timerState;

  setTimerState(timerState) {
    _timerState = timerState;
    notifyListeners();
  }

  decrementNotificationsCount() {
    if (_notificationsCount != 0) {
      _notificationsCount--;
      notifyListeners();
    }
  }

  getSelectedPage() => _selectedPage;

  setSelectedPage(page) {
    _selectedPage = page;
    notifyListeners();
  }

  getAuthenticationStage() => _authenticationStage;

  setAuthenticationStage(stage) {
    _authenticationStage = stage;
    notifyListeners();
  }

  getPhoneNumber() => _phoneNumber;

  getAuthResult() => _authResult;

  setAuthResult(result) {
    _authResult = result;
    notifyListeners();
  }

  setPhoneNumber(number) {
    _phoneNumber = number;
    notifyListeners();
  }

  getSosButtonState() => _sosButtonState;

  setSosButtonState(sosState) {
    _sosButtonState = sosState;
    notifyListeners();
  }

  startLoading() {
    _loadingStatus = loading.started;
    notifyListeners();
  }

  endLoading() {
    _loadingStatus = loading.finished;
    notifyListeners();
  }

}
