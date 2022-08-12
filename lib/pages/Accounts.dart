import 'package:flutter/material.dart';
import 'package:shop_manager/components/button.dart';
import 'package:shop_manager/components/textFields.dart';
import 'package:shop_manager/pages/widgets/clipPath.dart';

class Accounts extends StatefulWidget {
  final String? tag;
  const Accounts({Key? key, this.tag}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                padding: EdgeInsets.only(
                    right: height * 0.02,
                    left: height * 0.02,
                    top: widget.tag == 'dashboard' ? 0 : height * 0.13,
                    bottom: height * 0.07),
                color: theme.primaryColor,
                child: HeaderSection(
                  title: 'Account History',
                  height: height,
                  width: width,
                  theme: theme,
                  trailing: IconButton(
                    icon: const Icon(Icons.search, size: 40, color: Colors.white),
                    onPressed: () {
                      _searchAccount(context);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              child: Container(
                width: width * 0.9,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 245, 255),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Grand Total',
                          style: theme.textTheme.headline1!
                              .copyWith(fontSize: 17)),
                      SizedBox(height: height * 0.01),
                      Text('GHS2000.00',
                          style: theme.textTheme.headline1!
                              .copyWith(color: theme.primaryColor)),
                    ]),
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width * 0.3,
                      child: Text('Item Name',
                          style: theme.textTheme.bodyText1!
                              .copyWith(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: width * 0.3,
                      child: Text('Quantity',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText1!
                              .copyWith(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: width * 0.3,
                      child: Text('Total',
                          textAlign: TextAlign.end,
                          style: theme.textTheme.bodyText1!
                              .copyWith(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: AccountList(width: width, theme: theme),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _searchAccount(context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: theme.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: height * 0.7,
            padding: EdgeInsets.all(height * 0.02),
            child: Wrap(
              spacing: 20,
              children: <Widget>[
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: height * 0.02, top: height * 0.04),
                  child: Text("Search Account History",
                      style: theme.textTheme.headline2),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: height * 0.04,
                  ),
                  child: DateTextField(
                      controller: fromDate,
                      hintText: 'From',
                      hintColor: Colors.white,
                      borderColor: Colors.white,
                      prefixIcon: const Icon(Icons.calendar_today,
                          color: Colors.white, size: 20),
                      style: theme.textTheme.bodyText2),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: height * 0.04,
                  ),
                  child: DateTextField(
                      controller: toDate,
                      hintText: 'To',
                      hintColor: Colors.white,
                      borderColor: Colors.white,
                      prefixIcon: const Icon(Icons.calendar_today,
                          color: Colors.white, size: 20),
                      style: theme.textTheme.bodyText2),
                ),
                SizedBox(height: height * 0.1),
                Button(
                  color: theme.primaryColorLight,
                  textColor: theme.primaryColor,
                  width: width,
                  buttonText: "Done",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: height * 0.4),
              ],
            ),
          );
        });
  }
}

class AccountList extends StatelessWidget {
  const AccountList({
    Key? key,
    required this.theme,
    required this.width,
  }) : super(key: key);

  final ThemeData theme;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: width * 0.3,
            child: Text('Milk', style: theme.textTheme.bodyText1)),
        SizedBox(
            width: width * 0.3,
            child: Text('2',
                textAlign: TextAlign.center, style: theme.textTheme.bodyText1)),
        SizedBox(
            width: width * 0.3,
            child: Text('GHS12.00',
                textAlign: TextAlign.end, style: theme.textTheme.bodyText1)),
      ],
    );
  }
}
