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
  Map<DateTime, List> holidays = Map();
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
    if (events.length == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ServicoPage(id: events[0].id)));
    }

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

  bool isWeekendOrHoliday(DateTime date) =>
      date.weekday == DateTime.sunday ||
      date.weekday == DateTime.saturday ||
      this.holidays.containsKey(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildTableCalendar(),
          Divider(
            height: 1,
            thickness: 1,
            indent: 13,
            endIndent: 13,
            color: Colors.grey[350],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("${dateFormat.format(selectedDay)}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isWeekendOrHoliday(selectedDay)
                        ? Colors.red
                        : Colors.black)),
          ),
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
        todayDayBuilder: (context, date, events) {
          bool isSelected = calendarController.isSelected(date);
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(width: 0)
                        : Border.all(width: 1, color: Colors.blue),
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                  width: 42.0,
                  height: 42.0,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(
                        color: isSelected
                            ? isWeekendOrHoliday(date)
                                ? Colors.red[100]
                                : Colors.white
                            : isWeekendOrHoliday(date)
                                ? Colors.red
                                : Colors.black,
                      ),
                    ),
                  ),
                )
              ]);
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
                  ? Colors.blue
                  : isWeekendOrHoliday(date)
                      ? Colors.red
                      : Colors.black87,
            ),
            width: 42.0,
            height: 42.0,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                  color: calendarController.isSelected(date) &&
                          isWeekendOrHoliday(date)
                      ? Colors.red[100]
                      : Colors.white,
                ),
              ),
            ),
          )
        ]);
  }

  Widget buildEventList() {
    if (selectedEvents.length == 0) {
      return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Text("Nenhum serviço para este dia!",
              style: TextStyle(fontSize: 18)));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final item = selectedEvents[index];
        final isLast = selectedEvents.length == (index + 1);

        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.nome),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (item.tipo == 'vermelha'
                                      ? Colors.red
                                      : Colors.black)),
                              padding:
                                  new EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                              width: 85,
                              child: Text(item.tipo,
                                  style: TextStyle(color: Colors.white)))
                        ],
                      )
                    ]),
              ),
              onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicoPage(id: item.id)))
                  .then((_) => getEventsByDay(selectedDay)),
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 60,
              endIndent: 20,
              color: isLast ? Colors.white : Colors.grey[350],
            ),
          ],
        );
      },
    );
  }
}
