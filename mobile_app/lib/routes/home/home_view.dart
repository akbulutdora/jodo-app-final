import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/navigation/app_router.dart';
import 'package:jodo_app/repo/jodo_repository.dart';
import 'package:jodo_app/routes/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:jodo_app/routes/jodos_list/bloc/jodos_list_bloc.dart';
import 'package:jodo_app/util/action_status.dart';
import 'package:jodo_app/util/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          JodosOverviewBloc(jodoRepository: context.read<JodoRepository>())
            ..add(const JodosOverviewSubscriptionRequested()),
      child: AutoTabsRouter(
        // list of your tab routes
        // routes used here must be declared as children
        // routes of /dashboard
        routes: const [
          TodosListRoute(),
          NotesListRoute(),
        ],
        builder: (context, child, animation) {
          // obtain the scoped TabsRouter controller using context
          final tabsRouter = AutoTabsRouter.of(context);
          // Here we're building our Scaffold inside of AutoTabsRouter
          // to access the tabsRouter controller provided in this context
          //
          //alternatively you could use a global key
          var isTodosView = tabsRouter.activeIndex == 0;
          return Scaffold(
              floatingActionButton: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isTodosView
                      ? AppColors.todosPrimaryColor
                      : AppColors.notesPrimaryColor,
                ),
                curve: Curves.easeInOut,
                child: FloatingActionButton(
                  onPressed: () {
                    context.router.push(CreateJodoRoute(
                      jodo: Jodo(
                          title: '',
                          text: '',
                          type: isTodosView ? JodoType.todo : JodoType.note),
                    ));
                  },
                  tooltip: 'Add Note',
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: const Icon(Icons.add),
                ),
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isTodosView
                        ? AppColors.todosPrimaryColor
                        : AppColors.notesPrimaryColor,
                  ),
                  curve: Curves.easeInOut,
                  child: AppBar(
                    leading: BlocConsumer<JodosOverviewBloc, JodosOverviewState>(
                      listener: (context, state){
                        if (state.status == ActionStatus.failure){
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Failed to get your notes'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              context.read<JodosOverviewBloc>().add(
                                  const JodosOverviewSubscriptionRequested());
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 28,
                            ));
                      },
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            context.read<AuthenticationBloc>().add(LoggedOut());
                          },
                          icon: const Icon(Icons.logout))
                    ],
                    title: Text(isTodosView ? 'Todos' : 'Notes'),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ),
              body: FadeTransition(
                opacity: animation,
                // the passed child is technically our animated selected-tab page
                child: child,
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: isTodosView
                    ? AppColors.todosPrimaryColor
                    : AppColors.notesPrimaryColor,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    label: 'Todos',
                    icon: Icon(Icons.check_box),
                    activeIcon: Icon(
                      Icons.check_box,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Notes',
                    icon: Icon(Icons.edit),
                  )
                ],
              ));
        },
      ),
    );
  }
}
