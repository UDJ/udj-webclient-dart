part of udjlib;

// OfflineSyncService
// ============================================================================

/**
 * Service that will keep important information synced offline.
 * We extend [View] so that we get the watch functionality.
 */
class OfflineSyncService {
  UdjApp _udj;
  
  UdjService _service;
  
  // async bools
  bool _joinPlayerComplete;
  get joinPlayerComplete => _joinPlayerComplete;
  set joinPlayerComplete(bool val) {
    _joinPlayerComplete = val;
    dispatch();
  }
  
  // Constructor
  // --------------------------------------------------------------------------
  
  /**
   * The constructor that builds the OfflineSyncService.  It also performs
   * an initial load.
   */
  OfflineSyncService(this._udj,this._service):
  _joinPlayerComplete = false
  {
    // watch async bools to test for completeness
    watch(() => joinPlayerComplete, _checkLoadComplete);
    _loadFromStorage();
    
    // update the localstorage
    watch(() => _service.session, _saveSession);
    watch(() => _udj.state.currentPlayer, _saveCurrentPlayer);
  }
  
  // Load
  // --------------------------------------------------------------------------
  
  /**
   * Try to load saved info, if it's still valid.
   */
  void _loadFromStorage(){
    // must come first, so other functions that require a user to be logged in
    // will have the necessary session info
    if(window.localStorage.containsKey('session')){
      _service.session = new Session.fromJson(JSON.parse(window.localStorage['session']));
      _udj.state.currentUsername = _service.session.username;
    }

    // must come before player-related actions, so functions that requre a
    // player will have the necessary player info
    if(window.localStorage.containsKey('player')){
      // TODO: check for 'has_password' and decouple calls to joinPlayer and joinProtectedPlayer
      
      Map playerData = JSON.parse(window.localStorage['player']);
      _service.joinPlayer(playerData['id'], (Map status) {
        if (status['success'] == true) {
          _udj.state.currentPlayer = new Player.fromJson(playerData);
          joinPlayerComplete = true;

        } else {
          // if the player requires a password, try to join it with one
          if (status['error'] == Errors.PLAYER_PROTECTED) {
            String password = js.context.window.prompt("Enter the player's password", '');
            if (password != null) {
              _service.joinProtectedPlayer(playerData['id'], password, (Map status) {
                if (status['success']) {
                  _udj.state.currentPlayer = new Player.fromJson(playerData);
                  joinPlayerComplete = true;
                } else {
                  _udj.state.currentPlayer = null;
                  joinPlayerComplete = true;
                }   
              
              });
            }
            
          } else {
            _udj.state.currentPlayer = null;
            joinPlayerComplete = true;
          }
          
        }
        
      });
      
    } else {
      _udj.state.currentPlayer = null;
      joinPlayerComplete = true;
      
    }
    
  }
  
  /**
   * When all loading async requests have completed, the app state is ready.
   */
  void _checkLoadComplete(e) {
    if (joinPlayerComplete == true) {
      _udj.state.ready = true;
    }
  }
  
  // Save
  // --------------------------------------------------------------------------
  
  /**
   * Save the current session (user info).
   */
  void _saveSession(e){
    if(_service.session == null){
      window.localStorage.remove('session');
    }else{
      window.localStorage['session'] = JSON.stringify(_service.session);
    }
  }
  
  /**
   * Save the currently joined player.
   */
  void _saveCurrentPlayer(_) {
    if(_udj.state.currentPlayer == null){
      window.localStorage.remove('player');
      
    }else{
      window.localStorage['player'] = JSON.stringify(_udj.state.currentPlayer);
      
    }
  }
  
  
}
