// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/models/task_model.dart';
import 'package:my_todo/screens/home/components/task_tile.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/utils/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<TaskModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<TaskModel> _getEventsForDay(DateTime day) {
    final tasksBloc = BlocProvider.of<TaskBloc>(context);
    final currentState = tasksBloc.state;

    final List<TaskModel> pendingTasks =
        currentState.pendingTasks.where((task) {
      // Chuyển đổi ngày của công việc thành ngày không có thời gian
      final taskDate = DateTime.parse(task.date);
      print(taskDate);
      final taskDay = DateTime(taskDate.year, taskDate.month, taskDate.day);

      return isSameDay(taskDay, day);
    }).toList();

    final List<TaskModel> completedTasks =
        currentState.compeletedTasks.where((task) {
      // Chuyển đổi ngày của công việc thành ngày không có thời gian
      final taskDate = DateTime.parse(task.date);
      final taskDay = DateTime(taskDate.year, taskDate.month, taskDate.day);

      return isSameDay(taskDay, day);
    }).toList();
    final List<TaskModel> allTasks = [...pendingTasks, ...completedTasks];

    return allTasks;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Calendar',
              style: textTheme.displayMedium,
            ),
            TableCalendar<TaskModel>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                  todayDecoration:
                      BoxDecoration(color: MOVIE_COLOR, shape: BoxShape.circle),
                  markerDecoration: BoxDecoration(
                      color: SOCIAL_COLOR, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: PRIMARY_COLOR, shape: BoxShape.circle)),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<TaskModel>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
                    child: ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return taskTile(
                            textTheme: textTheme,
                            task: value[index],
                            context: context,
                            index: index,
                            type: 'pending');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
