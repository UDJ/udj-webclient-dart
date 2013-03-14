part of udjlib;


class LibraryState {
  final UdjApp _udj; 
 
  List<Song> _results;
  
  // Getter + Setter
  get results => _results;
  set results (List l) {
    _results = l;
    dispatch();
  }
  
  
  
  LibraryState(this._udj):
    _results = null {
    
  }
  
  void setLibraryView(){
    if(_udj.state.currentPlayer != null){
      if(_udj.state.libraryView == "Random"){
        _udj.service.getRandomLibrary(_udj.state.currentPlayer.value.id, _processLibraryResults); 
      }else if(_udj.state.libraryView == "Recent"){
        _udj.service.getRecentLibrary(_udj.state.currentPlayer.value.id, _processLibraryResults);
      }else if(_udj.state.libraryView == "Search"){
        _udj.service.getSearchLibrary(_udj.state.currentPlayer.value.id,_udj.state.searchQuery,
            _processLibraryResults);
      }
    }
  }
    
  void _processLibraryResults(Map res){
    List songs = new List<Song>();
    for(var s in res['data']){
      songs.add(new Song.fromJson(s));
    }
    
    results = songs;
  }
}
