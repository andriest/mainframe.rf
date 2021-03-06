import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:$name_snake_case$_mobile/api/api_client.dart';
import 'package:$name_snake_case$_mobile/blocs/$name_snake_case$/$name_snake_case$_event.dart';
import 'package:$name_snake_case$_mobile/blocs/$name_snake_case$/$name_snake_case$_state.dart';
import 'package:$name_snake_case$_mobile/user_repository/user_repository.dart';

class $name_pascal_case$Bloc extends Bloc<$name_pascal_case$Event, $name_pascal_case$State> {
  final UserRepository userRepository;
  $name_pascal_case$Bloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  $name_pascal_case$State get initialState => $name_pascal_case$Loading();

  @override
  Stream<$name_pascal_case$State> mapEventToState($name_pascal_case$Event event) async* {
    if (event is LoggedIn) {
      yield* _mapLogin$name_pascal_case$ToState(event);
    } else if (event is StartupEvent) {
      print("Got startup event");
      yield* _mapStartupToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<$name_pascal_case$State> _mapLogin$name_pascal_case$ToState(LoggedIn event) async* {
    yield AuthenticationLoading();
    await userRepository.persistToken(event.token);
    yield AuthenticationAuthenticated();
  }

  Stream<$name_pascal_case$State> _mapStartupToState(StartupEvent event) async* {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      yield AuthenticationAuthenticated();
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<$name_pascal_case$State> _mapLoggedOutToState(LoggedOut event) async* {
    yield AuthenticationLoading();
    await userRepository.deleteToken();
    ApiResource.accessToken = "";
    yield AuthenticationUnauthenticated();
  }

}
