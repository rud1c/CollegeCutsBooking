import 'package:flutter/material.dart';
import 'FadePage.dart';




class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BarberBookingHomePage(),
    );
  }
}

class BarberBookingHomePage extends StatelessWidget {
  const BarberBookingHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Cuts'),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.transparent, // Transparent background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[900]!],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 40.0,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                child: const Text(
                  'Book with COBC\'s Barbers now!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100.0),
            const Text(
              'Choose Your Service:',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            FullServiceOption(
              title: 'Fade',
              icon: Icons.content_cut,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingPage()),
                );
              },
            ),
            FullServiceOption(
              title: 'Scissors',
              icon: Icons.cut,
              onPressed: () {
                // Handle service option selection
              },
            ),
            FullServiceOption(
              title: 'Beard',
              icon: Icons.cut,
              onPressed: () {
                // Handle service option selection
              },
            ),
            FullServiceOption(
              title: 'View Bookings',
              icon: Icons.calendar_month,
              onPressed: () {
                // Handle service option selection
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FullServiceOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  const FullServiceOption({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[600], // Set background color to white
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black), // Icon color
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black), // Text color
          ),
        ),
      ),
    );
  }
}
