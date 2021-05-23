import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  CardListTile({this.leadingIcon, this.title, this.trailingIcon});
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(title == null ? '' : title),
        trailing: Icon(trailingIcon),
      ),
    );
  }
}
