import 'package:flutter/material.dart';
import 'package:km_test/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/user_provider.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<UserModel> userList = [];

  final ScrollController _scrollController = ScrollController();

  Future<void> _onRefresh() async {
    context.read<UserProvider>().refresh();
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && context.read<UserProvider>().hasMore) {
      context.read<UserProvider>().fetchUser();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchUser();
    _scrollController.addListener(onScroll);
  }

  void _saveUser(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_username', value).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/second', ModalRoute.withName('/second'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Third Screen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/second', ModalRoute.withName('/second'));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0.1,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Consumer<UserProvider>(builder: (_, state, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF2B637B),
                    ),
                  );
                }
                if (state.users.isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: Text('Data is empty!'),
                  ));
                }
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasMore
                        ? state.users.length + 1
                        : state.users.length,
                    itemBuilder: (context, index) {
                      if (index < state.users.length) {
                        return InkWell(
                          onTap: () {
                            _saveUser(
                                "${state.users[index].firstName} ${state.users[index].lastName}");
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.users[index].avatar ?? '')),
                              title: Text(
                                  "${state.users[index].firstName} ${state.users[index].lastName}" ??
                                      ''),
                              subtitle: Text(state.users[index].email ?? ''),
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }
                    });
              },
            ),
          );
        }),
      ),
    );
  }
}
