import 'dart:async';
import 'dart:convert' as convert;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pingo_learn_practical/infrastructure/app_routes/app_navigation.dart';
import 'package:pingo_learn_practical/infrastructure/app_routes/name_routes.dart';
import 'package:pingo_learn_practical/infrastructure/model/comment_model.dart';

import '../../../infrastructure/repository/auth_repository.dart';
import '../../../infrastructure/service/remote_config_service.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  AuthRepository authRepository;

  CommentBloc(this.authRepository) : super(CommentState()) {
    on<InitializeRemoteConfig>(_onInitializeRemoteConfig);
    on<FetchComments>(_onFetchComments);
    on<Logout>(_onLogout);
  }

  Future<FutureOr<void>> _onFetchComments(FetchComments event, Emitter<CommentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    List<CommentModel> commentList = [];
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List;
      commentList = jsonResponse.map((x) => CommentModel.fromJson(x)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    emit(state.copyWith(isLoading: false, commentList: commentList));
  }

  Future<void> _onLogout(Logout event, Emitter<CommentState> emit) async {
    try {
      await authRepository.signOut();
    } on FirebaseAuthException catch (e) {
      AppNavigator.showSnackBar('Error', e.toString());
    }
    AppNavigator.toRemoveAllName(NamedRoutes.signupScreen);
  }

  FutureOr<void> _onInitializeRemoteConfig(InitializeRemoteConfig event, Emitter<CommentState> emit) async {
    RemoteConfigService remoteConfigService = await RemoteConfigService.getInstance();
    emit(state.copyWith(isHideEmail: remoteConfigService.isHideEmail));
  }
}
