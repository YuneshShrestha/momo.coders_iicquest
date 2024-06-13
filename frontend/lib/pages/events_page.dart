import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_sathi/controllers/events.dart';
import 'package:virtual_sathi/models/videos_model.dart';
import 'package:virtual_sathi/widgets/event_widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> getAnonymousAccount() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    if (userCredential.user != null) {
      print('User ID: ${userCredential.user!.uid}');
    }
  }

  List<EventsModel> _events = [];
  void _fetchEvents() async {
    await getAnonymousAccount();
    final User? user = FirebaseAuth.instance.currentUser;
    final List<EventsModel> events = await EventsController.getVideos(
      user!.uid,
    );
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String date = DateTime.now().toString();

                      return AlertDialog(
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return SizedBox(
                              height: 250,
                              width: 400,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text('Create an event'),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Event Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final newDate = await showDatePicker(
                                          context: ctx,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );

                                        if (newDate == null) {
                                          return;
                                        }
                                        setState(() {
                                          date = newDate.toString();
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(date),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      hint: const Text('Event Type'),
                                      onChanged: (value) {},
                                      items: const [
                                        DropdownMenuItem(
                                          child: Text('General'),
                                          value: 'General',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Event'),
                                          value: 'Event',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Help'),
                                          value: 'Help',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Create'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              },
            ),
          ],
        ),
        body: _events.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    eventModel: _events[index],
                  );
                },
              ));
  }
}
