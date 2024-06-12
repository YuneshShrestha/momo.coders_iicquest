import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_sathi/pages/events_page.dart';
import 'package:virtual_sathi/widgets/post_widget.dart';

class VirtualSathi extends StatefulWidget {
  const VirtualSathi({super.key});

  @override
  State<VirtualSathi> createState() => _VirtualSathiState();
}

class _VirtualSathiState extends State<VirtualSathi> {
  late double width;
  @override
  void initState() {
    width = 1;

    super.initState();
  }

  void getAnonymousAccount() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print(userCredential.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Sathi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EventsPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text('Create a post'),
                              const TextField(
                                decoration: InputDecoration(
                                  hintText: 'What\'s on your mind?',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Category dropdown
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                hint: const Text('Category'),
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
                                onChanged: (value) {},
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  getAnonymousAccount();
                                },
                                child: const Text('Post'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * width,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const PostWidget();
                }),
          ),
          // const VerticalDivider(),
          Expanded(
            child: Container(
              color: Theme.of(context).brightness == Brightness.dark? Color.fromARGB(255, 30, 9, 9): const Color.fromARGB(255, 20, 20, 20),
              child: Stack(
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            width = width == 1 ? 0.7 : 1;
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: width == 1
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  width = width == 1 ? 0.7 : 1;
                });
              },
              child: const Icon(Icons.chat_bubble_outline),
            )
          : null,
    );
  }
}
