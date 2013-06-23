part of udjlib;

class PlayerCreateState {
  
  final UdjApp _udj;
  
  PlayerCreateState(this._udj);
  
  void formSubmit(Map playerAttrs) {
    _udj.service.createPlayer(playerAttrs, (Map status) {
      if (status['success']) {
        Player p = new Player.fromJson( status['playerData'] );
        
        _udj.service.setPlayerState(p.id, 'paused', (Map status) {
          if (status['success']) {
            _udj.service.addPlayerLibrary(p.id, "1", (Map status) {
              if (status['success']) {
                //_udj.state.localPlayer = p;
                _udj.state.currentPlayer = p;
                _udj.state.creatingPlayer = false;
                
              } else {
                // TODO: error handling

              }
            }); // close addPlayerLibrary
            
          } else {
            // TODO: error handling
          }
        }); // close setPlayerState
        
      } else {
        // TODO: error handling
      }
    }); // close createPlayer
  }
  
}
