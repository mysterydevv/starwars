import 'package:flutter/material.dart';
import 'package:flutter_movie/models/cinema/place.dart';
import 'package:flutter_movie/models/event/event.dart';
import 'package:flutter_movie/models/user_account.dart';
import 'package:flutter_movie/services/account_service.dart';
import 'package:flutter_movie/services/cinema_service.dart';
import 'package:flutter_movie/services/event_service.dart';
import 'package:flutter_movie/utils/helpers.dart';
import 'package:intl/intl.dart';

class OrderDialog extends StatefulWidget {
  final Place place;
  final String cinemaId;

  const OrderDialog({super.key, required this.place, required this.cinemaId});

  @override
  OrderDialogState createState() => OrderDialogState();
}



class OrderDialogState extends State<OrderDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  CinemaService cinemaService = CinemaService();
  EventService eventService = EventService();
  AccountService accountService = AccountService();
  late UserAccount user;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    accountService.getAccount().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime!.hour < 10 || pickedTime.hour > 22) {
      // ignore: use_build_context_synchronously
      Helper.showErrorDialog(context, 'Время должно быть между 10:00 и 22:00');
      return;
    }
    setState(() {
      _selectedTime = pickedTime;
    });
    }

  void _orderPlace() async {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      final DateTime dateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      widget.place.isOrdered = true;
      widget.place.email = user.email;
      
      var event = Event(
        null,
        user.id!,
        widget.cinemaId,
        widget.place,
        dateTime,
      );
      eventService.addEvent(event)
      .then((value) => null)
      .catchError((error) {
        Helper.showErrorDialog(context, error.toString());
      });
      cinemaService.updatePlace(widget.place, widget.cinemaId)
      .then((value) => null)
      .catchError((error) {
        Helper.showErrorDialog(context, error.toString());
      });
      Navigator.of(context).pop(widget.place);
    }
    else {
      Helper.showErrorDialog(context, 'Пожалуйста, заполните все поля');
    }
  }

  void _cancelOrder() {
    widget.place.isOrdered = false;
    Navigator.of(context).pop(widget.place);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Бронирование места ${widget.place.number}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя пользователя'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(
                  _selectedDate == null
                      ? 'Выберите дату'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickTime,
                child: Text(
                  _selectedTime == null
                      ? 'Выберите время'
                      : _selectedTime!.format(context),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancelOrder,
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed:  _orderPlace,
          child: const Text('Купить'),
        ),
      ],
    );
  }
}
