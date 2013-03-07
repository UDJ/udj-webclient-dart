part of udjlib;

/**
 * The login state object.
 */
class LoginState {
  String errorMessage;
  
  final UdjApp _udjApp;
  
  // constructors
  
  LoginState(this._udjApp):
    errorMessage = null;
  
  // methods
  
  void login(String username, String password){
    errorMessage = "LoggedIn???";
    /*
    _udjApp.service.login(username, password, (success){
      if(!success){
        errorMessage = "Username and password did not match. Please try again.";
      }else{
        errorMessage = null;
        _udjApp.state.currentUsername.value = username;
      }
    });
    */
  }
}
