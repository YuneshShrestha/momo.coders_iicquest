import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Sathi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 200,
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
                                onPressed: () {},
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
              color: Colors.grey,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            width = width == 1 ? 0.7 : 1;
          });
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
