import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchComments extends CommentEvent {
  FetchComments();

  @override
  List<Object?> get props => [];
}

class Logout extends CommentEvent {
  Logout();

  @override
  List<Object?> get props => [];
}