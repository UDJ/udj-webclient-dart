part of udjlib;

/**
 * The global state object.
 */
class UdjState {
  String _currentUsername;
  get currentUsername => _currentUsername;
  set currentUsername(String val) {
    _currentUsername = val;
    dispatch();
  }
  
  String _playerState;
  get playerState => _playerState;
  set playerState(String val) {
    _playerState = val;
    dispatch();
  }
  
  int playerVolume;
  
  Player _currentPlayer;
  get currentPlayer => _currentPlayer;
  set currentPlayer(Player val) {
    _currentPlayer = val;
    dispatch();
  }
    
  QueueSong _nowPlaying;
  get nowPlaying => _nowPlaying;
  set nowPlaying(QueueSong song) {
    _nowPlaying = song;
    dispatch();
  }
  
  List<QueueSong> _queue;
  get queue => _queue;
  set queue(List<QueueSong> val) {
    _queue = val;
    dispatch();
  }
  
  String libraryView;
  
  String searchQuery;
  
  Song librarySongs;
  
  bool _ready;
  get ready => _ready;
  set ready(bool val) {
    _ready = val;
    dispatch();
  }
  
  bool _creatingPlayer;
  get creatingPlayer => _creatingPlayer;
  set creatingPlayer(bool val) {
    _creatingPlayer = val;
    dispatch();
  }
  
  final UdjApp _udjApp;
      
  UdjState(this._udjApp): 
    _currentUsername = null,
    _playerState = null,
    playerVolume = null,
    _currentPlayer = null,
    _nowPlaying = null,
    _queue = null,
    libraryView = null,
    searchQuery = null,
    librarySongs = null,
    _ready = false,
    _creatingPlayer = false;
  
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
