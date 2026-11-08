import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ziaul_64g_441/auth/Login_page.dart';
import 'package:ziaul_64g_441/auth/auth_gate.dart';

void main() async{

     WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url:'https://viyyiektcgxoglchqzks.supabase.co' ,
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZpeXlpZWt0Y2d4b2dsY2hxemtzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTQwNjE4NTUsImV4cCI6MjEwOTYzNzg1NX0.quVsymwSgiCAICU3s2gvt3BUewyx7kMYawfhuhZTcHg',
     );
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home:AuthGate() );
  }
}