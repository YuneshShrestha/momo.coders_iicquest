import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtual_sathi/models/videos_model.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    required this.eventModel,
    required this.categoryName,
    required this.index,
  });
  final EventsModel eventModel;
  final String categoryName;
  final int index;
  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  Future<void> _launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get only www.google.com from https://www.google.com/headers/
    final url = widget.eventModel.url!.split('/')[2];
    final Uri toLaunch = Uri(scheme: 'https', host: url, path: 'headers/');
    return SizedBox(
      height: 1,
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.event),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Event Name ${widget.index + 1}'),
                        Chip(
                          label: Text(widget.categoryName),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => setState(() {
                            _launched = _launchURL(toLaunch);
                          }),
                          child: const Text('Visit Session Link'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
