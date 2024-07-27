import 'package:equatable/equatable.dart';

import '../../../infrastructure/model/comment_model.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final List<CommentModel> commentList;

  const CommentState({this.isLoading = true, this.commentList = const []});

  CommentState copyWith({
    bool? isLoading,
    List<CommentModel>? commentList,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  List<Object?> get props => [isLoading, commentList];
}
