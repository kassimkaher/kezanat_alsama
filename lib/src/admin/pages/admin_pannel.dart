import 'package:flutter_svg/svg.dart';
import 'package:ramadan/src/admin/pages/calendar/calendar_admin_page.dart';
import 'package:ramadan/src/admin/pages/posts/all_posts.dart';
import 'package:ramadan/src/admin/pages/relationships/relation_admin_page.dart';
import 'package:ramadan/src/admin/pages/work/works_admin_page.dart';
import 'package:ramadan/utils/utils.dart';

class AdminPageView extends StatefulWidget {
  const AdminPageView({super.key});

  @override
  State<AdminPageView> createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin pannel"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 1 / 1.2),
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, to(const WorkAdminPage())),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: RadialGradient(
                            center: Alignment.topCenter,
                            colors: [Colors.white, theme.primaryColor])),
                    child: SvgPicture.asset(
                      "assets/svg/dua.svg",
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "اعمال",
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, to(const RelationAdminPage())),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: RadialGradient(
                            center: Alignment.topCenter,
                            colors: [
                              Colors.amber.shade100,
                              Colors.amber.shade900
                            ])),
                    child: SvgPicture.asset(
                      "assets/svg/relations.svg",
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "مناسبات",
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, to(const AllPostsView())),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: RadialGradient(
                            center: Alignment.topCenter,
                            colors: [Colors.white, theme.primaryColor])),
                    child: SvgPicture.asset(
                      "assets/svg/reading.svg",
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "اقوال",
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, to(const CalendarAdminView())),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Image.asset(
                      "assets/images/calendar.png",
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "التقويم",
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'اعمال',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'مناسبات',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'اقوال',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'التوقيت',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: theme.primaryColor,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
