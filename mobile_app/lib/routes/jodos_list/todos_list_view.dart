import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/routes/jodos_list/bloc/jodos_list_bloc.dart';
import 'package:jodo_app/ui_components/cards/todo_card.dart';
import 'package:jodo_app/util/action_status.dart';
import 'package:jodo_app/util/colors.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<JodosOverviewBloc, JodosOverviewState>(
        listener: (context, state) {
          if (state.status == ActionStatus.success) {
            context.router.pop();
          }
        },
        builder: (context, state) {
          if (state.status == ActionStatus.submitting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.todosPrimaryColor,
            ));
          }
          if (state.todos.isEmpty) {
            return const Center(
              child: Text(
                "You have no todos!\nWhy don't you start making some plans?",
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(thickness: 2,),
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return JodoCard(
                      jodo: state.todos[index],
                      onDelete: (context) {
                        context
                            .read<JodosOverviewBloc>()
                            .add(JodosOverviewJodoDeleted(state.todos[index]));
                      },
                      onChanged: (bool? value) {
                        final jodo = state.todos[index];
                        context.read<JodosOverviewBloc>().add(
                            JodosOverviewJodoCompletionToggled(
                                jodo: jodo, isCompleted: value!));
                      },
                    );
                  }));
        },
      ),
    );
  }
}
