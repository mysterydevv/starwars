import 'package:flutter/material.dart';

class DateSelection extends StatefulWidget {
  const DateSelection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DateSelectionState createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      // Открываем модальное окно для заполнения формы покупки билета
      // ignore: use_build_context_synchronously
      await _showTicketForm(context);
    }
  }

  Future<void> _showTicketForm(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Форма покупки билета'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Имя человека'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Количество билетов'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Зал и ряд'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Информация о банковском счете'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                // Обработка отправки формы
                Navigator.of(context).pop();
              },
              child: const Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Купить билеты'),
        ),
      ],
    );
  }
}