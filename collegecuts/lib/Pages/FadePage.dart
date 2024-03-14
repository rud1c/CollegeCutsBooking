import 'package:flutter/material.dart';
import 'package:any_animated_button/any_animated_button.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book a fade now!',
          style: TextStyle(color: Colors.teal),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.teal, // Teal line color
            height: 4.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _selectDate,
              child: Text(
                _selectedDate == null
                    ? 'Select a date'
                    : 'Selected date: ${_selectedDate.toString().substring(0, 10)}',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Select Time:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            // Add your time selection widget here
            // You can use dropdown, slider, or any other widget
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality to confirm the booking here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.black.withOpacity(0.5)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: BookingPage(),
  ));
}
