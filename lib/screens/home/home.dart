import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galvan_webapp/screens/home/home_cubit.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit(), child: HomeBody());
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            title: Text('Home'),
            leading: IconButton(
              onPressed: () {
                cubit.scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Navigation Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.input),
                  title: Text('NFT'),
                  onTap: () {
                    context.push('/nft_form');
                  },
                ),
              ],
            ),
          ),
          body: Center(child: Text('Home Screen')),
        );
      },
    );
  }
}
