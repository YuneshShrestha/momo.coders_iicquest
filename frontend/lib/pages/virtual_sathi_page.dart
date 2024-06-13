import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_sathi/controllers/categories.dart';
import 'package:virtual_sathi/controllers/posts.dart';
import 'package:virtual_sathi/models/category_model.dart';
import 'package:virtual_sathi/models/post_model.dart';
import 'package:virtual_sathi/pages/events_page.dart';
import 'package:virtual_sathi/widgets/post_widget.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

class VirtualSathi extends StatefulWidget {
  const VirtualSathi({super.key});

  @override
  State<VirtualSathi> createState() => _VirtualSathiState();
}

class _VirtualSathiState extends State<VirtualSathi> {
  late bool isPoppedUp;
  late GoogleSignIn _googleSignIn;
  List<CategoryModel> categoryModel = [];
  @override
  void initState() {
    isPoppedUp = false;
    _googleSignIn = GoogleSignIn(
      clientId:
          '273574887067-mo2p7vaa6u61kp2e4fn6tp9266rvg4bh.apps.googleusercontent.com',
    );
    getCategories();
    // loadTFLiteModel();
    super.initState();
  }

  void getCategories() async {
    final data = await CategoriesController.fetchCategories();
    setState(() {
      categoryModel = data;
    });
  }

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

  // void loadTFLiteModel() async {
  //   final interpreter = await Interpreter.fromAsset('assets/model.tflite');
  //   print(interpreter.getInputTensors());
  //   print(interpreter.getOutputTensors());
  // }

  Future<List<PostModel>> fetchPostsFiltered(bool isFiltered,
      [String? categoryID]) async {
    if (isFiltered && categoryID != null) {
      return PostsController.fetchPostsByCategories(categoryID);
    } else {
      return PostsController.fetchPosts();
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: AppBar(
                  title: const Text('Aparichit Sathi'),
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
                                            if (FirebaseAuth
                                                    .instance.currentUser ==
                                                null) {
                                              await getAnonymousAccount();
                                            }

                                            try {
                                              final data =
                                                  await PostsController.addPost(
                                                title: _titleController.text,
                                                description:
                                                    _descriptionController.text,
                                                userId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              );
                                              print(data);
                                              if (data == true &&
                                                  context.mounted) {
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
              ),
            ],
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Category'),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _category = value.id ?? '';
                        });
                      },
                      items: categoryModel.map((CategoryModel category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name ?? 'Unknown Category'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 9,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: FutureBuilder<List<PostModel>>(
                          future: fetchPostsFiltered(
                            false,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                  isLast: index == snapshot.data!.length - 1,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // const VerticalDivider(),
                isPoppedUp
                    ? Positioned(
                        right: 0,
                        bottom: 60,
                        top: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height,
                          child: const Padding(
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
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isPoppedUp = !isPoppedUp;
          });
        },
        backgroundColor: isPoppedUp ? Colors.red : Colors.deepPurple,
        child: isPoppedUp
            ? const Icon(Icons.close)
            : const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
