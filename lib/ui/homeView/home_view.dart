import 'package:at_list/services/services.dart';
import 'package:at_list/ui/homeView/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    print('Home view built');
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.initialize();
      },
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [ListTile(
                  title: Text('Logout'),
                  onTap: (){
                    atProtocolService.logout(context);
                  },
                ),
                  ListTile(
                    title: Text('Show At Signs'),
                    onTap: (){
                      atProtocolService.getSigns();
                    },
                  ),],
              ),
            ),
            body: Builder(
              builder: (context) => CustomScrollView(
                shrinkWrap: true,
                // controller: model.scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 160,
                    floating: true,
                    elevation: 4,
                    shape: ContinuousRectangleBorder(
                        side:
                            BorderSide(width: 2, color: CupertinoColors.black)),
                    title: Text(atProtocolService.atSign ?? '-'),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // profile
                        },
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.all(8),
                      title: Text(
                        'At Lists',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: ListTile(
                            leading: Checkbox(
                              onChanged: (bool value) {},
                              value: false,
                            ),
                            title: Text('Task $index'),
                          ),
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print('new tile');
              },
              shape:
                  CircleBorder(side: BorderSide(color: Colors.black, width: 2)),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
