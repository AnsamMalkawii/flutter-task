import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../providers/alphabets_provder.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custome_text.dart';
import '../log_in_screen/login_screen.dart';
import 'widgets/card_tile.dart';

class HomeScreen extends StatefulWidget {
  static const namedRoute = '/home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AlpabetsProviders>().getAndFetchAlphabets();
    super.initState();
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(csharedLogged, false);
    Navigator.of(context).pushNamed(LogInScreen.namedRoute);
  }

  @override
  Widget build(BuildContext context) {
    var alphabets = context.watch<AlpabetsProviders>().alphabets;
    var user = context.watch<AuthProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut();
        },
        child: Icon(Icons.logout),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomeText(
                  label: user.user!.name,
                  color: Colors.black,
                  size: 24,
                  alignment: Alignment.center,
                ),
                CustomeText(
                  label: user.user!.email,
                  color: Colors.black,
                  size: 24,
                  alignment: Alignment.center,
                ),
                CustomeText(
                  label: user.userAge.toString(),
                  color: Colors.black,
                  size: 24,
                  alignment: Alignment.center,
                ),

                SizedBox(
                  height: 60,
                ),

                //TextButton.icon(onPressed: (){}, icon: Icon(Icons.logout), label: Text('Sign Out')),
                Text(
                  'Alphapatical',
                  style: TextStyle(fontSize: 32),
                ),
                Expanded(
                    child: Container(
                  child: GridView.builder(
                    itemCount: alphabets.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20),
                    // mainAxisExtent: 1 / 2,
                    //mainAxisSpacing: 2),
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: alphabets[index], child: CardTile());
                    },
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
