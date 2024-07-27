import 'package:equatable/equatable.dart';

import '../../../infrastructure/model/comment_model.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final bool? isHideEmail;
  final List<CommentModel> commentList;

  const CommentState({this.isHideEmail, this.isLoading = true, this.commentList = const []});

  CommentState copyWith({
    bool? isLoading,
    bool? isHideEmail,
    List<CommentModel>? commentList,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      commentList: commentList ?? this.commentList,
      isHideEmail: isHideEmail ?? this.isHideEmail,
    );
  }

  @override
  List<Object?> get props => [isLoading, commentList, isHideEmail];
}
