import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/routes/jodos_list/bloc/jodos_list_bloc.dart';
import 'package:jodo_app/ui_components/cards/todo_card.dart';
import 'package:jodo_app/util/action_status.dart';
import 'package:jodo_app/util/colors.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

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
              color: AppColors.notesPrimaryColor,
            ));
          }
          if (state.notes.isEmpty) {
            return const Center(
              child: Text(
                "You have no notes!\nGet that clever mind of yours working!",
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(thickness: 2,),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    var note = state.notes[index];
                    return JodoCard(
                      jodo: note,
                      onDelete: (context) {
                        context
                            .read<JodosOverviewBloc>()
                            .add(JodosOverviewJodoDeleted(note));
                      },
                      onChanged: (bool? value) {
                        final jodo = note;
                        context.read<JodosOverviewBloc>().add(
                            JodosOverviewJodoCompletionToggled(
                                jodo: jodo, isCompleted: jodo.completedAt != null));
                      },
                    );
                  }));
        },
      ),
    );
  }
}
