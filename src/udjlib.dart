library udjlib;
import 'dart:async';
import 'dart:html';
import 'dart:isolate';
import 'dart:json';
import 'dart:uri';

import 'package:js/js.dart' as js;

import 'lib/requestHelper.dart';

part 'UdjConstants.dart';
//part 'services/OfflineSyncService.dart';
//part 'services/PollService.dart';

// app level 
part 'UdjApp.dart';
part 'services/UdjService.dart';
part 'UdjStructs.dart';

// views
//part 'views/MainView.dart';
//part 'views/LoginView.dart';
/*
part 'views/TopBarView.dart';
part 'views/PlayerCreateView.dart';
part 'views/PlayerSelectView.dart';
part 'views/LibraryView.dart';
part 'views/SideBarView.dart';
part 'views/SongView.dart';
part 'views/AdminPlayerView.dart';
part 'views/AdminUserView.dart';
*/

// view models
part 'view_models/UdjState.dart';
part 'view_models/LoginState.dart';
/*
part 'view_models/PlayerCreateState.dart';
part 'view_models/PlayerSelectState.dart';
part 'view_models/LibraryState.dart';
part 'view_models/TopBarState.dart';
part 'view_models/SideBarState.dart';
part 'view_models/AdminPlayerState.dart';
part 'view_models/AdminUserState.dart';
*/