part of udjlib;

/**
 * The login state object.
 */
class LoginState extends UIState{
  final ObservableValue<String> errorMessage;
  
  final UdjApp _udjApp;
  
  // constructors
  
  LoginState(this._udjApp):
    super(),
    errorMessage = new ObservableValue<String>(null);
  
  // methods
  
  void login(String username, String password){
    _udjApp.service.login(username, password, (success){
      if(!success){
        errorMessage.value = "Username and password did not match. Please try again.";
      }else{
        errorMessage.value = null;
        _udjApp.state.currentUsername.value = username;
      }
    });
  }
}
