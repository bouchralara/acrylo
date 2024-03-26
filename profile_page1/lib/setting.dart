import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

ThemeData currentTheme = ThemeData.light();

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  void updateTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات التطبيق'),
      ),
      body: SettingsContent(),
    );
  }
}

class SettingsContent extends StatefulWidget {
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  String _selectedLanguage = 'العربية';
  bool _notificationsEnabled = true;
  String _selectedTheme = 'النمط الفاتح';

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _changeTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
      currentTheme =
          theme == 'النمط الفاتح' ? ThemeData.light() : ThemeData.dark();
    });
  }
void _logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("تأكيد تسجيل الخروج"),
        content: Text("هل أنت متأكد من رغبتك في تسجيل الخروج؟"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop(); // هنا يتم إغلاق التطبيق بشكل صحيح
            },
            child: Text("تأكيد"),
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(_selectedLanguage),
      theme: _selectedTheme == 'النمط الفاتح'
          ? ThemeData.light()
          : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('إعدادات التطبيق'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: Text(
                'اللغة',
                textAlign: TextAlign.left,
              ),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  _changeLanguage(newValue!);
                },
                items: <String>['العربية', 'English', 'Français']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: Text(
                'الإشعارات',
                textAlign: TextAlign.left,
              ),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: _toggleNotifications,
              ),
            ),
            ListTile(
              title: Text(
                'الخصوصية',
                textAlign: TextAlign.left,
              ),
              trailing: Icon(Icons.keyboard_arrow_left),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PrivacyPage()));
              },
            ),
            ListTile(
              title: Text(
                'سمة التطبيق',
                textAlign: TextAlign.left,
              ),
              trailing: DropdownButton<String>(
                value: _selectedTheme,
                onChanged: (String? newValue) {
                  _changeTheme(newValue!);
                },
                items: <String>['النمط الفاتح', 'النمط الداكن']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: Text(
                'الحساب',
                textAlign: TextAlign.left,
              ),
              trailing: Icon(Icons.keyboard_arrow_left),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'معلومات عن التطبيق',
                textAlign: TextAlign.left,
              ),
              trailing: Icon(Icons.keyboard_arrow_left),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppInfoPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'تسجيل الخروج',
                textAlign: TextAlign.left,
              ),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}





class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // استخدم السمة المحددة التي تم تحديدها عبر المتغير العام
      theme: currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('سياسة الخصوصية'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نحن نولي أهمية كبيرة لخصوصية مستخدمينا ونلتزم بحماية معلوماتهم الشخصية. يرجى قراءة سياسة الخصوصية التالية لفهم كيفية جمع واستخدام وحماية المعلومات التي تقدمها لنا:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'جمع المعلومات:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'نقوم بجمع بعض المعلومات الشخصية عندما تستخدم تطبيقنا، مثل الاسم وعنوان البريد الإلكتروني ومعلومات الاتصال الأخرى. نحن نستخدم هذه المعلومات لتقديم خدماتنا وتحسين تجربة المستخدم.',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'حفظ المعلومات:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'نحن نلتزم بحفظ جميع المعلومات التي تقدمها لنا بسرية تامة. لن نشارك هذه المعلومات مع أي طرف ثالث دون موافقتك الصريحة، إلا في الحالات المنصوص عليها بموجب القانون.',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'التغييرات في سياسة الخصوصية:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'نحتفظ بالحق في تحديث أو تغيير سياسة الخصوصية في أي وقت. سيتم نشر أي تغييرات على هذه الصفحة، لذا يرجى مراجعتها بانتظام للحصول على المعلومات الأحدث حول كيفية حماية معلوماتك الشخصية.',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'الاتصال بنا:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'إذا كان لديك أي أسئلة أو استفسارات حول سياسة الخصوصية، يمكنك التواصل معنا عبر البريد الإلكتروني على example@example.com.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}










class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'تطبيق العقارات',
          theme: themeProvider.currentTheme, // استخدام السمة من مزود الحالة
          home: AccountPage(),
        );
      },
    );
  }
}

class AccountPage extends StatelessWidget {
  // يمكنك استبدال هذه البيانات بالبيانات الفعلية للمستخدم
  final String userName = "اسم المستخدم";
  final String userEmail = "example@example.com";
  final String joinDate =
      "1 يناير، 2022"; // يمكنك استبدال هذا بتاريخ الانضمام الفعلي للمستخدم
  final int propertiesListed = 5; // عدد العقارات المدرجة للمستخدم
  final int propertiesBookmarked = 3; // عدد العقارات المفضلة للمستخدم
  final int messagesUnread = 2; // عدد الرسائل غير المقروءة للمستخدم
  final int upcomingAppointments = 1; // عدد المواعيد القادمة للمستخدم
  final int rentedProperties = 2; // عدد العقارات المستأجرة الحالية
  final int availableProperties = 7; // عدد العروض العقارية المتاحة للإيجار
  final double monthlyPayments =
      2500.00; // المدفوعات الشهرية للعقارات المستأجرة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة الحساب'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // صورة المستخدم
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/user_avatar.png'), // يمكنك استبدال هذا بمسار الصورة الفعلي
                radius: 50.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'معلومات الحساب',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              _buildInfoTile('اسم المستخدم', userName),
              _buildInfoTile('البريد الإلكتروني', userEmail),
              _buildInfoTile('تاريخ الانضمام', joinDate),
              _buildInfoTile('العقارات المدرجة', propertiesListed.toString()),
              _buildInfoTile(
                  'العقارات المفضلة', propertiesBookmarked.toString()),
              _buildInfoTile('الرسائل غير المقروءة', messagesUnread.toString()),

              _buildInfoTile(
                  'المواعيد القادمة', upcomingAppointments.toString()),
              // العقارات المستأجرة الحالية
              _buildInfoTile(
                  'العقارات المستأجرة الحالية', rentedProperties.toString()),
              // عروض العقارات المتاحة
              _buildInfoTile(
                  'عروض العقارات المتاحة', availableProperties.toString()),
              // المدفوعات الشهرية
              _buildInfoTile(
                  'المدفوعات الشهرية', '$monthlyPayments دينار جزائري'),
              // العقارات المستأجرة الحالية
              _buildInfoTileWithNavigation(
                  'المواعيد المحددة للعروض', Icons.keyboard_arrow_left, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentsPage()),
                );
              }),
              // تقييمات المستأجرين السابقين
              _buildInfoTileWithNavigation(
                  'تقييمات المستأجرين السابقين', Icons.keyboard_arrow_left, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewsPage()),
                );
              }),
              // زر تحرير الحساب
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditAccountPage()), // توجيه لصفحة تحرير الحساب
                  );
                },
                child: Text('تحرير الحساب'),
              ),
              // إضافة توجيهات للمستخدم حول استخدام التطبيق
              Text(
                'للمساعدة في استخدام التطبيق، يرجى زيارة قسم الأسئلة الشائعة.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTileWithNavigation(
      String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: onTap,
    );
  }
}

class EditAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحرير الحساب'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'اسم المستخدم'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // يمكنك هنا تنفيذ الشيفرة اللازمة لحفظ التغييرات
                // يمكنك أيضًا إضافة تحقق من الصحة هنا
                _showSaveConfirmationDialog(context);
              },
              child: Text('حفظ التغييرات'),
            ),
          ],
        ),
      ),
    );
  }

  // عرض مربع حوار لتأكيد حفظ التغييرات
  Future<void> _showSaveConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحفظ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('هل أنت متأكد أنك تريد حفظ التغييرات؟'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                // هنا يمكنك تنفيذ الشيفرة اللازمة لحفظ التغييرات
                Navigator.of(context).pop();
                _showSaveSuccessSnackBar(context);
              },
            ),
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // عرض شريط إشعار بنجاح الحفظ
  void _showSaveSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('تم حفظ التغييرات بنجاح'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class AppointmentsPage extends StatelessWidget {
  final List<String> appointmentDates = [
    '25 مارس، 2024 - 10:00 صباحًا',
    '28 مارس، 2024 - 2:00 مساءً',
    '3 أبريل، 2024 - 11:30 صباحًا',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المواعيد المحددة للعروض'),
      ),
      body: ListView.builder(
        itemCount: appointmentDates.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appointmentDates[index]),
            // يمكنك إضافة المزيد من المعلومات هنا مثل تفاصيل العرض
          );
        },
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  final List<String> reviews = [
    'تمت تجربة التطبيق وهو ممتاز بالفعل!',
    'لقد كانت تجربتي رائعة مع التطبيق، شكرًا لكم!',
    'أنا راضٍ تمامًا عن الخدمة التي قدمتموها، أتطلع للمزيد من العروض.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقييمات المستأجرين السابقين'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reviews[index]),
            // يمكنك إضافة المزيد من المعلومات هنا مثل اسم المستأجر وتقييمه بالنجوم
          );
        },
      ),
    );
  }
}
















class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // استخدم متغير السمة currentTheme
      theme: currentTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('معلومات التطبيق'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تطبيق كراء العقارات',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'وصف التطبيق:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'تطبيق كراء العقارات هو تطبيق مصمم لتسهيل عملية إيجار العقارات بطريقة مريحة وسهلة للمستخدمين. يوفر التطبيق واجهة سهلة الاستخدام للبحث عن العقارات المتاحة وترتيب المواعيد للعروض والعديد من الميزات الأخرى.',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'ميزات التطبيق:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- البحث عن العقارات المتاحة للإيجار بسهولة.',
                  ),
                  Text(
                    '- ترتيب المواعيد لعرض العقارات.',
                  ),
                  Text(
                    '- عرض تفاصيل العقارات بما في ذلك الصور والأسعار.',
                  ),
                  // يمكنك إضافة المزيد من الميزات هنا
                  SizedBox(height: 20.0),
                  Text(
                    'المطور:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'شركة عقارات المستقبل',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'الإصدار الحالي:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'الإصدار 1.0.0',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'للتواصل:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'البريد الإلكتروني: info@futureproperties.com',
                  ),
                  Text(
                    'الهاتف: +1234567890',
                  ),
                  SizedBox(height: 20.0), // مساحة بين النصوص والحافة السفلية
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
