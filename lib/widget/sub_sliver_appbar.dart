import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/model/user.dart';
import 'package:youtube_clone/provider/selected_category_index.dart';

class SubSliverAppbar extends StatelessWidget {
  const SubSliverAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                        subUsers('title', context),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'All',
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categories('All', context, 0),
                    categories('Today', context, 1),
                    categories('Continue Watching', context, 2),
                    categories('Unwatched', context, 3),
                    categories('Live', context, 4),
                    categories('Posts', context, 5),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget subUsers(String title, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: () {},
          icon: CircleAvatar(
            foregroundImage: NetworkImage(
              currentUser.profileImageUrl,
            ),
          ),
        ),
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }

  Widget categories(String title, BuildContext context, int setIndex) {
    return Consumer<SelectedCategoryIndex>(
      builder: (context, provider, _) {
        return Container(
          height: 50,
          padding: const EdgeInsets.all(6),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: provider.selectedIndex == setIndex
                  ? Colors.white
                  : Colors.grey[600],
            ),
            onPressed: () {
              provider.changeIndex(setIndex);
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: provider.selectedIndex == setIndex
                        ? Colors.black
                        : Colors.white,
                  ),
            ),
          ),
        );
      },
    );
  }
}
