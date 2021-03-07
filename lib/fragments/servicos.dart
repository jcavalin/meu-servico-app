import 'package:flutter/material.dart';
import 'package:meu_servico_app/pages/servico.dart';
import 'package:meu_servico_app/services/servico-service.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> holidays = {
  DateTime(2021, 3, 1): ['New Year\'s Day'],
  DateTime(2021, 3, 2): ['Epiphany'],
  DateTime(2021, 3, 14): ['Valentine\'s Day'],
  DateTime(2021, 3, 21): ['Easter Sunday'],
  DateTime(2021, 3, 22): ['Easter Monday'],
};

class ServicosPage extends StatefulWidget {
  ServicosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ServicosState createState() => new ServicosState();
}

class ServicosState extends State<ServicosPage> with TickerProviderStateMixin {
  Map<DateTime, List> events;
  List selectedEvents;
  AnimationController animationController;
  CalendarController calendarController;
  final service = ServicoService();

  @override
  void initState() {
    super.initState();
    final selectedDay = DateTime.now();

    service.list().forEach((servicos) {
      Map<DateTime, List> items = Map();

      servicos.forEach((servico) {
        if (items[servico.data] == null) {
          items[servico.data] = List();
        }

        items[servico.data].add(servico);
      });

      setState(() => events = items);
    });

    selectedEvents = events != null && events[selectedDay] != null
        ? events[selectedDay]
        : [];
    calendarController = CalendarController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    calendarController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: onDaySelected');
    setState(() {
      selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildTableCalendar(),
          Text("Serviços"),
          Expanded(child: buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServicoPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget buildTableCalendar() {
    return TableCalendar(
      calendarController: calendarController,
      events: events,
      holidays: holidays,
      locale: 'pt_BR',
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        selectedColor: Colors.lightBlueAccent,
        todayColor: Colors.blue,
        markersColor: Colors.blueGrey,
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.red),
        holidayStyle: TextStyle().copyWith(color: Colors.red),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      onDaySelected: onDaySelected,
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(buildEventsMarker(date, events));
          }

          // if (holidays.isNotEmpty) {
          //   children.add(
          //     Positioned(
          //       right: -2,
          //       top: -2,
          //       child: buildHolidaysMarker(),
          //     ),
          //   );
          // }

          return children;
        },
      ),
    );
  }

  Widget buildEventsMarker(DateTime date, List events) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: calendarController.isSelected(date)
                  ? Colors.brown[500]
                  : calendarController.isToday(date)
                      ? Colors.brown[300]
                      : Colors.black87,
            ),
            width: 42.0,
            height: 42.0,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]);
  }

  Widget buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget buildEventList() {
    if (selectedEvents.length == 0) {
      return Text("Nenhum serviço para este dia!");
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final item = selectedEvents[index];

        return ListTile(
          leading: Icon(Icons.calendar_today_outlined),
          title: Text(item.toString()),
          subtitle: Text("nada"),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicoPage(id: item.id))),
        );
      },
    );
  }
}
