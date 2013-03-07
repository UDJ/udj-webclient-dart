part of udjlib;

/**
 * The global state object.
 */
class UdjState {
  String currentUsername;
  
  String playerState;
  
  int playerVolume;
  
  Player currentPlayer;
  
  Player localPlayer;
  
  QueueSong nowPlaying;
  
  List<QueueSong> queue;
  
  String libraryView;
  
  String searchQuery;
  
  Song librarySongs;
  
  bool ready;
  
  bool creatingPlayer;
  
  final UdjApp _udjApp;
      
  UdjState(this._udjApp): 
    currentUsername = null,
    playerState = null,
    playerVolume = null,
    currentPlayer = null,
    localPlayer = null,
    nowPlaying = null,
    queue = null,
    libraryView = null,
    searchQuery = null,
    librarySongs = null,
    ready = false,
    creatingPlayer = false;
  
  
  // mulit view / state utilities
    
  // TODO: old code? remove?
  void voteSong(String action,String songId){
    _udjApp.service.voteSong(action,currentPlayer.id,songId,(res){
      
    });
  }
  
  // TODO: old code? remove?
  void addSong(String songId){
    _udjApp.service.addSong(currentPlayer.id,songId,(res){
      
    });
  }
  
  /**
   * Make sure the user is in a player and is an admin of that player.
   */
  bool canAdmin() {
    Player p = currentPlayer;
    String name = currentUsername;
    
    if (p == null) {
      return false;
    }
    
    bool isAdmin = p.admins.any((User admin) {
      return admin.username == name;
    });
    bool isOwner = p.owner.username == name;
    
    return isAdmin || isOwner;
  }
  
}
