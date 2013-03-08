part of udjlib;

/**
 * Class that begins the whole app. This will be passed around 
 * to most objects, so it has access to some globals [state] and 
 * [service] that will be access by many different parts.
 */
class UdjApp {
  /// The global state object
  UdjState state;
  
  /// the global service object
  UdjService service;
  
  /// Service that keeps ofline in sync
  // OfflineSyncService _offlineSync;
  
  /// Service to poll the server for changes to queue and now playing
  // PollService _pollService;
  
  UdjApp() {
    state = new UdjState(this);
    service = new UdjService(_loginNeeded);
    
//    _offlineSync = new OfflineSyncService(this,service);
//    _pollService = new PollService(this);
  }
  
  void pollPlayer(Timer t){
    if(state.currentPlayer != null){
      service.pollPlayer(state.currentPlayer.id,(Map data){
        if(data['success']){
          state.playerState = data['data']['state'];
          state.playerVolume = data['data']['volume'];
          if(!data['data']['current_song'].isEmpty){
            state.nowPlaying = new QueueSong.fromJson(data['data']['current_song']);
          }
          List queue = new List<QueueSong>();
          for(var s in data['data']['active_playlist']){
            queue.add(new QueueSong.fromJson(s));
          }
          state.queue = queue;
        }
      });
    }
  }
  
  /**
   * Callback fired by [service] when a re-auth is needed.
   * By setting the [state.currentUsername] to null, we will cause
   * the login screen to be displayed.
   */
  void _loginNeeded(){
    state.currentUsername = null;
  }
}
