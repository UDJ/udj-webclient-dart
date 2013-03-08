part of udjlib;

/**
 * The login state object.
 */
class LoginState {
  String errorMessage;
  
  final UdjApp _udj;
  
  // constructors
  
  LoginState(this._udj):
    errorMessage = null;
  
  // methods
  
  void login(String username, String password){
    _udj.service.login(username, password, (success){
      if(!success){
        errorMessage = "Username and password did not match. Please try again.";
        dispatch();
      }else{
        errorMessage = null;
        _udj.state.currentUsername = username;
      }
    });
  }
}
