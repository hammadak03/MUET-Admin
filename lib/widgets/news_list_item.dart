import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/news_model.dart';
import '../database/news_handler.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';

class NewsListItem extends StatelessWidget {
  final NewsModel news;

  const NewsListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    DateTime newsDate = DateTime.tryParse(news.date ?? '') ?? DateTime.now();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Container(
          width: ScreenUtils.width(context) * 0.25,
          height: ScreenUtils.width(context) * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white60,
          ),
          child: news.img != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              news.img!,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
          )
              : const Icon(Icons.image),
        ),
        title: Text(news.title ?? "No Title", style: const TextStyle(fontSize: 16, color: Colors.black)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(news.description ?? "No Description", style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 5.0),
            Text(DateFormat.yMMMd().format(newsDate), style: const TextStyle(fontSize: 12, color: Colors.black)),
            const SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press, e.g., navigate to a link
                if (news.link != null) {
                  // Navigate to the link
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlueColor,
              ),
              child: Text(news.link ?? "Read More", style: const TextStyle(color: whiteColor)),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete News'),
                  content: const Text('Are you sure you want to delete this news?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );

            if (shouldDelete == true && news.id != null) {
              await NewsHandler.deleteNews(news.id!);
            }
          },
        ),
      ),
    );
  }
}
