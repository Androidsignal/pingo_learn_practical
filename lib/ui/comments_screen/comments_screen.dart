import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingo_learn_practical/infrastructure/model/comment_model.dart';
import 'package:pingo_learn_practical/infrastructure/repository/auth_repository.dart';
import 'package:pingo_learn_practical/ui/comments_screen/bloc/comment_state.dart';

import 'bloc/comment_bloc.dart';
import 'bloc/comment_event.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(
        context.read<AuthRepository>(),
      )
        ..add(InitializeRemoteConfig())
        ..add(FetchComments()),
      child: const CommentsPage(),
    );
  }
}

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Comments',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CommentBloc>().add(Logout());
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
        centerTitle: false,
      ),
      body: BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
        if (state.isLoading) {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 20,
            color: Theme.of(context).primaryColor,
          ));
        }
        if (state.commentList.isEmpty) {
          return const Center(
            child: Text('No comments found'),
          );
        }
        return ListView.builder(
          itemCount: state.commentList.length,
          itemBuilder: (context, index) {
            CommentModel comment = state.commentList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).disabledColor,
                        child: Text(
                          (comment.name ?? "x").substring(0, 1).toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: 'Name :',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                children: [
                                  TextSpan(
                                    text: ' ${comment.name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              )),
                              const SizedBox(height: 8),
                              RichText(
                                  text: TextSpan(
                                text: 'Email :',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                children: [
                                  TextSpan(
                                    text: ' ${state.isHideEmail! ? maskEmail(comment.email!) : comment.email}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        subtitle: Text(comment.body ?? "", style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }


  String maskEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex <= 3) {
      return email;
    }
    String firstPart = email.substring(0, 3);
    String maskedPart = '*' * (atIndex - 3);
    String domainPart = email.substring(atIndex);
    return '$firstPart$maskedPart$domainPart';
  }
}
