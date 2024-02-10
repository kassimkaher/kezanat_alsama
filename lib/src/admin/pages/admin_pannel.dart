import 'package:ramadan/src/admin/pages/calendar/calendar_admin_page.dart';
import 'package:ramadan/src/admin/pages/posts/all_posts.dart';
import 'package:ramadan/src/admin/pages/work/all_work.dart';
import 'package:ramadan/utils/utils.dart';

class AdminPageView extends StatefulWidget {
  const AdminPageView({super.key});

  @override
  State<AdminPageView> createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {
  int _selectedIndex = 0;
  final views = [
    const AllDailyWorkView(),
    const AllPostsView(),
    const CalendarAdminView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin pannel"),
      ),
      body: views.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'اعمال',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'اقوال',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'التوقيت',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
