import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'setting.dart'; // استيراد صفحة الإعدادات

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // يمكن تغيير هذا اللون حسب الحاجة
        
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/profilepage.png'),
            ),
            const SizedBox(height: 20),
            itemProfile('الاسم', 'لعرابة بشرى', CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('الهاتف', '03107085816', CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile(
                'العنوان', 'abc address, xyz city', CupertinoIcons.location),
            const SizedBox(height: 10),
            itemProfile('البريد الالكتروني', 'bouchradeveloper@gmail.com',
                CupertinoIcons.mail),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  primary: Color.fromARGB(255, 244, 168, 173), // تحديد لون الزر
                ),
                child: const Text('صفحة الاعدادات'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 82, 82).withOpacity(.2), // تحديد لون الخلفية
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromARGB(255, 236, 232, 233).withOpacity(.2), // تحديد لون الظل
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          subtitle,
          textAlign: TextAlign.right,
        ),
        trailing: Icon(
          iconData,
          color: Colors.white,
        ),
        leading: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Color(0xFFEC6971), // تحديد لون البلاطة
      ),
    );
  }
}
