import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_servico_app/pages/servico.dart';
import 'package:meu_servico_app/services/feriado-service.dart';
import 'package:meu_servico_app/services/servico-service.dart';
import 'package:table_calendar/table_calendar.dart';

class ServicosPage extends StatefulWidget {
  ServicosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ServicosState createState() => new ServicosState();
}

class ServicosState extends State<ServicosPage> with TickerProviderStateMixin {
  final service = ServicoService();
  final serviceFeriado = FeriadoService();
  final dateFormat = DateFormat('dd/MM/yyyy');

  Map<DateTime, List> events;
  Map<DateTime, List> holidays;
  List selectedEvents;
  AnimationController animationController;
  CalendarController calendarController;
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

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

    serviceFeriado.list().forEach((feriados) {
      Map<DateTime, List> items = Map();

      feriados.forEach((feriado) {
        if (items[feriado.data] == null) {
          items[feriado.data] = List();
        }

        items[feriado.data].add(feriado.descricao);
      });

      setState(() => holidays = items);
    });

    getEventsByDay(selectedDay);

    selectedEvents = [];
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
    selectedDay = day;
    getEventsByDay(selectedDay);
  }

  void getEventsByDay(DateTime data) {
    service.listByDate(data).then((servicos) {
      List items = List();

      servicos.forEach((servico) => items.add(servico));

      setState(() => selectedEvents = items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildTableCalendar(),
          Text("Serviços - ${dateFormat.format(selectedDay)}"),
          Expanded(child: buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServicoPage(
                    data: DateTime(
                        selectedDay.year, selectedDay.month, selectedDay.day))),
          ).then((_) => getEventsByDay(selectedDay));
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
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.blue),
            ),
            child: Center(
              child: Text(
                '${date.day}',
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(buildEventsMarker(date, events));
          }

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

  Widget buildEventList() {
    if (selectedEvents.length == 0) {
      return Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text("Nenhum serviço para este dia!",
              style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final item = selectedEvents[index];

        return ListTile(
          leading: Icon(Icons.calendar_today_outlined),
          title: Text(item.nome),
          subtitle: Text(item.tipo,
              style: TextStyle(
                  color:
                      (item.tipo == 'vermelha' ? Colors.red : Colors.black))),
          onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServicoPage(id: item.id)))
              .then((_) => getEventsByDay(selectedDay)),
        );
      },
    );
  }
}
