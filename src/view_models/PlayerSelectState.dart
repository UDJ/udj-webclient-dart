part of udjlib;

// PlayerSelectState
// ============================================================================

class PlayerSelectState {
  /// The [UdjApp] (which provides access to the [UdjState]).
  final UdjApp _udj;
  
  /*/// Variables to watch.
  final ObservableValue<List<Player>> players;
  final ObservableValue<Player> prevPlayer;
  final ObservableValue<bool> loading;
  final ObservableValue<bool> hidden;
  final ObservableValue<String> errorMessage;*/
  
  List<Player> players;
  Player prevPlayer;
  bool loading;
  String errorMessage;
  
  // Constructors
  // --------------------------------------------------------------------------
  
  /**
   * Create the [PlayerSelectState].
   */
  PlayerSelectState(this._udj):
    players = null,
    prevPlayer = null,
    loading = false,
    hidden = true,
    errorMessage = null;
  
  // Methods
  // --------------------------------------------------------------------------
  
  /**
   * Get the players by geolocation.
   */
  void getPlayers(){
    //errorMessage = null;
    
    window.navigator.geolocation.getCurrentPosition(
      (Geoposition position){
        _udj.service.getPlayersByPosition(position, (Map status) {
          if (status['success']) {
            players = _buildPlayers(status['players']);
          } else {
            // TODO: handle errors more specifically
            errorMessage = "Geolocation lookup failed.  Please search for a player.";
          }
        });
      }, 
      (e){
        errorMessage = "Geolocation lookup failed.  Please search for a player.";
      });
  }

  /**
   * Get the player by searching (for its name).
   */
  void searchPlayer(String search) {
    _udj.service.getSearchPlayer(search, (Map status) {
      if (status['success']) {
        players = _buildPlayers(status['players']);
      } else {
        // TODO: handle errors more specifically
        // TODO: fall back to geolocation??? At least allow the users to get back to geolocation resutls.
        errorMessage = "Search lookup failed.  Please refresh the page and try again.";
      }
    });
  }
  
  /**
   * Build a list of players from json.
   */
  List<Player> _buildPlayers(List playersData) {
    List<Player> players = new List<Player>();
    for (var data in playersData) {
      players.add(new Player.fromJson(data));
    }
    
    return players;
  }
  
  /**
   * Attempt to join a player.
   */
  void joinProtectedPlayer(String playerID, String password) {
    // TODO: should we be leaving then joining the same player?
    leavePlayer(playerID);
    
    _udj.service.joinProtectedPlayer(playerID, password, (Map status) {
      _handleJoining(playerID, status);
    });
  }
  
  /**
   * Attempt to join a player.
   */
  void joinPlayer(String playerID) {
    // TODO: should we be leaving then joining the same player?
    leavePlayer(playerID);
    
    _udj.service.joinPlayer(playerID, (Map status) {
      _handleJoining(playerID, status);
    });
  }
  
  /**
   * Handle joining the player.
   */
  void _handleJoining(String playerID, Map status) {
    if (status['success'] == true) {
      for (Player p in players) {
        if (p.id == playerID) {
          _udj.state.currentPlayer.value = p;
        }
      }
      
    } else {
      // TODO: test errors - currently the server responds correctly but the browser gives an error:
      // Refused to get unsafe header "X-Udj-Forbidden-Reason"
      var error = status['error'];
      
      if (error == Errors.PLAYER_FULL) {
        errorMessage = "The server is full.";
        
      } else if (error == Errors.PLAYER_BANNED) {
        errorMessage = "You have been banned from this server.";
        // TODO: reload the players list from the server- filter should be applied
        
      } else { // error == Errors.UNKOWN
        errorMessage = "There was an error joining the server.";
        
      }
      
      // TODO: wrong password
    }
  }
  
  /**
   * Attempt to leave a player.
   */
  void leavePlayer(String playerID) {
    // TODO: should we be leaving then joining the same player?
    if (prevPlayer != null) {
      _udj.service.leavePlayer(prevPlayer.id, (Map status) {}); // empty callback since this is just a courtesy
    }
  }
  
}
