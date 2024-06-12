import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_sathi/controllers/posts.dart';
import 'package:virtual_sathi/models/post_model.dart';
import 'package:virtual_sathi/pages/events_page.dart';
import 'package:virtual_sathi/widgets/post_widget.dart';

class VirtualSathi extends StatefulWidget {
  const VirtualSathi({super.key});

  @override
  State<VirtualSathi> createState() => _VirtualSathiState();
}

class _VirtualSathiState extends State<VirtualSathi> {
  late double width;
  late GoogleSignIn _googleSignIn;
  List<PostModel> postModels = [];
  @override
  void initState() {
    width = 1;

    _googleSignIn = GoogleSignIn(
      clientId:
          '273574887067-mo2p7vaa6u61kp2e4fn6tp9266rvg4bh.apps.googleusercontent.com',
    );
    // getPosts();
    super.initState();
  }

  // void getPosts() async {
  //   final data = await PostsController.fetchPosts();
  //   setState(() {
  //     postModels = data;
  //   });
  // }

  Future<void> getAnonymousAccount() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    if (userCredential.user != null) {
      print('User ID: ${userCredential.user!.uid}');
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser);
    } catch (error) {
      print(error);
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Sathi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventsPage(),
                ),
              );
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
                              TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  hintText: 'What\'s on your mind?',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                maxLines: 3,
                                controller: _descriptionController,
                                decoration: const InputDecoration(
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
                                onChanged: (value) {
                                  setState(() {
                                    _category = value;
                                  });
                                },
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
                              ElevatedButton(
                                onPressed: () async {
                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    await getAnonymousAccount();
                                  }

                                  try {
                                    final data = await PostsController.addPost(
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    print(data);
                                    if (data == true && context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
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
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              _handleSignIn();
            },
            child: const Text('Sign in with Google'),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * width,
            child: FutureBuilder<List<PostModel>>(
              future: PostsController.fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading posts'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      postModel: snapshot.data![index],
                    );
                  },
                );
              },
            ),
          ),
          // const VerticalDivider(),
          Expanded(
            child: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 30, 9, 9)
                  : const Color.fromARGB(255, 20, 20, 20),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextField(
                          decoration: InputDecoration(
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
