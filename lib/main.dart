import 'package:flutter/material.dart';
import 'widgets/animate_a_widget_across_screens.dart';
import 'widgets/pass_arguments_to_a_named_route.dart';
import 'widgets/return_data_from_a_screen.dart';
import 'widgets/send_data_to_a_new_screen.dart';
import 'widgets/delete_data_on_the_internet.dart';
import 'widgets/fetch_data_from_the_internet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => AppHome(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/animate': (context) => FirstRoute(),
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct type: ScreenArguments.
          final ScreenArguments args = settings.arguments as ScreenArguments;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
      },
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final List<ListTileParams> _suggestions = [
    ListTileParams('Animate a widget across screens', FirstRoute()),
    ListTileParams('Pass arguments to a named route', ArgumentedRoute()),
    ListTileParams('Return data from a screen', ReturnData()),
    ListTileParams('Send data to a new screen', SendData()),
    ListTileParams('Delete data on the internet', DeleteData()),
    ListTileParams('Fetch data from the internet', FetchData()),
  ];
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: _suggestions.map((string) => _buildRow(string)).toList()
    );
  }

  Widget _buildRow(ListTileParams params) {
    return Column(
        children: [
          ListTile(
            title: Text(
              params.title,
              style: _biggerFont,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => params.page),
              );
            }
          ),
          Divider()
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}