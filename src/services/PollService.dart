part of udjlib;

// PollService
// ============================================================================

/**
 * Service that will get updates from the server.
 */
class PollService {
  // a function that performs the poll
  var _poll;
  
  Timer _timer;
  
  // Constructor
  // --------------------------------------------------------------------------
  
  PollService(this._poll){
    
  }
  
  // Methods
  // --------------------------------------------------------------------------
  
  /**
   * Starts polling the server.
   * 
   * The _poll function must have a Timer paramater since Timer.repeating
   * requires a callback with that parameter.
   */
  void start(_){
    _timer = new Timer.periodic(new Duration(milliseconds: Constants.POLL_INTERVAL), _poll);
    _poll(null);
  }
  
  /**
   * Stops polling the server.
   */
  void stop(){
    _timer.cancel();
  }
}
