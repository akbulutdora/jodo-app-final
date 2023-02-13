import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/navigation/app_router.dart';

import '../../util/colors.dart';

class JodoCard extends StatelessWidget {
  const JodoCard(
      {super.key,
      required this.jodo,
      required this.onChanged,
      required this.onDelete});

  final Jodo jodo;
  final void Function(bool?) onChanged;
  final void Function(BuildContext) onDelete;

  @override
  Widget build(BuildContext context) {
    debugPrint('value of jodo: $jodo');
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            spacing: 1,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: onDelete,
          ),
        ],
      ),
      child: GestureDetector(
          onTap: () {
            context.router.push(CreateJodoRoute(jodo: jodo));
          },
          child: ListTile(
            visualDensity: VisualDensity.comfortable,
            isThreeLine: false,
            title: Text(
              jodo.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              jodo.text ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: (jodo.type == JodoType.todo)
                ? Checkbox(
                    value: jodo.completedAt != null,
                    onChanged: onChanged,
                    activeColor: AppColors.todosPrimaryColor,
                  )
                : null,
          )),
    );
  }
}
