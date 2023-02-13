import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/repo/jodo_repository.dart';
import 'package:jodo_app/routes/create_update_jodo/bloc/create_jodo_cubit.dart';
import 'package:jodo_app/util/action_status.dart';
import 'package:jodo_app/util/colors.dart';
import 'package:jodo_app/util/dimensions.dart';

class CreateJodoView extends StatelessWidget {
  const CreateJodoView({Key? key, this.jodo}) : super(key: key);
  final Jodo? jodo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateJodoCubit(jodoRepository: context.read<JodoRepository>())
            ..initialize(jodo),
      child: BlocConsumer<CreateJodoCubit, CreateJodoState>(
        listener: (context, state) {
          switch (state.jodoStatus) {
            case ActionStatus.success:
              context.router.pop();
              break;
            case ActionStatus.failure:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage.isNotEmpty
                        ? state.errorMessage
                        : 'Failed to create that jodo'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: state.jodo.type == JodoType.todo
                        ? AppColors.todosPrimaryColor
                        : AppColors.notesPrimaryColor,
                  ),
                  curve: Curves.easeInOut,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(jodo?.id == null ? 'Create Jodo' : 'Edit Jodo'),
                  ),
                ),
              ),
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SafeArea(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(kHorizontalPadding),
                      padding: const EdgeInsets.all(kHorizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('What are you thinking about?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: kVerticalPadding * 3),
                                const Text('Title',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: kVerticalPadding / 2),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: state.jodo.type == JodoType.todo
                                        ? AppColors.todosPrimaryColor
                                            .withOpacity(0.3)
                                        : AppColors.notesPrimaryColor
                                            .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  curve: Curves.easeInOut,
                                  child: TextFormField(
                                    onChanged: (String value) {
                                      context
                                          .read<CreateJodoCubit>()
                                          .updateTitle(value);
                                    },
                                    initialValue: state.jodo.title,
                                    cursorColor: state.jodo.type == JodoType.todo
                                        ? AppColors.todosPrimaryColor
                                        : AppColors.notesPrimaryColor,
                                    decoration: InputDecoration(
                                      filled: false,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: kVerticalPadding * 2),
                                const Text('Description',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: kVerticalPadding / 2),
                                Expanded(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: state.jodo.type == JodoType.todo
                                          ? AppColors.todosPrimaryColor
                                              .withOpacity(0.3)
                                          : AppColors.notesPrimaryColor
                                              .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    curve: Curves.easeInOut,
                                    child: TextFormField(
                                      textAlignVertical: TextAlignVertical.top,
                                      expands: true,
                                      maxLines: null,
                                      minLines: null,
                                      onChanged: (String value) {
                                        context
                                            .read<CreateJodoCubit>()
                                            .updateDescription(value);
                                      },
                                      cursorColor:
                                          state.jodo.type == JodoType.todo
                                              ? AppColors.todosPrimaryColor
                                              : AppColors.notesPrimaryColor,
                                      initialValue: state.jodo.text ?? '',
                                      decoration: InputDecoration(
                                        filled: false,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                ),
                                if (state.jodo.createdAt != null) ...[
                                  const SizedBox(height: kVerticalPadding * 2),
                                  RichText(
                                      text: TextSpan(
                                          text: 'Created at: ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          children: [
                                        TextSpan(
                                            text: DateFormat('dd/MM/yyyy')
                                                .format(state.jodo.createdAt!),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal))
                                      ])),
                                ],
                                const SizedBox(height: kVerticalPadding),
                                Visibility(
                                  visible: state.jodo.type == JodoType.todo,
                                  maintainState: true,
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                    child: Row(
                                      children: [
                                        const Text('Completed',
                                            style: TextStyle(fontSize: 16)),
                                        const SizedBox(width: kHorizontalPadding),
                                        Checkbox(
                                            activeColor:
                                                AppColors.todosPrimaryColor,
                                            value: state.jodo.completedAt != null,
                                            onChanged: (bool? value) {
                                              debugPrint('value: $value');
                                              context
                                                  .read<CreateJodoCubit>()
                                                  .updateCompleted(value);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              jodo?.id == null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              state.jodo.type == JodoType.todo
                                                  ? 'Todo'
                                                  : 'Note',
                                              style: TextStyle(
                                                  color: state.jodo.type ==
                                                          JodoType.todo
                                                      ? AppColors
                                                          .todosPrimaryColor
                                                      : AppColors
                                                          .notesPrimaryColor),
                                            ),
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Switch(
                                                  activeColor:
                                                      AppColors.notesPrimaryColor,
                                                  inactiveThumbColor:
                                                      AppColors.todosPrimaryColor,
                                                  inactiveTrackColor: AppColors
                                                      .todosPrimaryColor
                                                      .withOpacity(0.6),
                                                  value: state.jodo.type !=
                                                      JodoType.todo,
                                                  onChanged: (value) {
                                                    debugPrint('value: $value');
                                                    context
                                                        .read<CreateJodoCubit>()
                                                        .updateType(value);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<CreateJodoCubit>()
                                                .deleteJodo();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text('Delete')),
                                    ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: state.jodo.type == JodoType.todo
                                      ? AppColors.todosPrimaryColor
                                      : AppColors.notesPrimaryColor,
                                ),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shadowColor: Colors.transparent),
                                    onPressed: () {
                                      context
                                          .read<CreateJodoCubit>()
                                          .createJodo();
                                    },
                                    child: const Text('Save')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
