import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/events_model.dart';
import '../database/events_handler.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_background.dart';
import 'add_events_screen.dart'; // Import the screen you want to navigate to

class UpdateEvents extends StatelessWidget {
  const UpdateEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomBackground(
              title: 'Update Events',
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtils.width(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      StreamBuilder<List<EventsModel>>(
                        stream: EventHandler.getEvents(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No events available'));
                          } else {
                            final events = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap:
                                  true, // Ensure the ListView takes the minimum height required
                              physics:
                                  const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];

                                // Parse the date string into a DateTime object
                                DateTime eventDate =
                                    DateTime.tryParse(event.date ?? '') ??
                                        DateTime.now();

                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListTile(
                                    leading: Container(
                                      width: ScreenUtils.width(context) * 0.25,
                                      height: ScreenUtils.width(context) * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white60,
                                      ),
                                      child: event.imageUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                event.imageUrl!,
                                                fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                (loadingProgress
                                                                        .expectedTotalBytes ??
                                                                    1)
                                                            : null,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            )
                                          : const Icon(Icons.event),
                                    ),
                                    title: Text(
                                      event.title ?? "No Title",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.description ?? "No Description",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          DateFormat.yMMMd().format(eventDate),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Handle button press, e.g., navigate to a link
                                            if (event.link != null) {
                                              // Navigate to the link
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: darkBlueColor,
                                          ),
                                          child: Text(
                                            event.buttonText ?? "Button",
                                            style: const TextStyle(
                                                color: whiteColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        // Show a confirmation dialog before deleting
                                        final shouldDelete =
                                            await showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Delete Event'),
                                              content: const Text(
                                                  'Are you sure you want to delete this event?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // If the user confirmed, delete the event
                                        if (shouldDelete == true &&
                                            event.id != null) {
                                          await EventHandler.deleteEvent(
                                              event.id!);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEventsScreen()),
          );
        },
        backgroundColor: darkBlueColor,
        child: const Icon(Icons.add, color: whiteColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
