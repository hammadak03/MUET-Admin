import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muet_app_admin/screens/add_news_screen.dart';
import '../Models/news_model.dart';
import '../database/news_handler.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_background.dart';
import '../widgets/news_list_item.dart';

class UpdateNewsScreen extends StatelessWidget {
  const UpdateNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomBackground(
              title: 'Update News',
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtils.width(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      StreamBuilder<List<NewsModel>>(
                        stream: NewsHandler.getNews(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No news available'));
                          } else {
                            final newsList = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                final news = newsList[index];
                                return NewsListItem(news: news);
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
            MaterialPageRoute(builder: (context) => const AddNewsScreen()),
          );
        },
        backgroundColor: darkBlueColor,
        child: const Icon(Icons.add, color: whiteColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
