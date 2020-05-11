import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: YanweiLiu(),
));

class YanweiLiu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('個人簡介'),
        centerTitle: true,
        backgroundColor: Colors.blue[850],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage('https://scontent-tpe1-1.xx.fbcdn.net/v/t1.0-9/14492368_1468759719807087_7594963659703372073_n.jpg?_nc_cat=102&_nc_oc=AQn_97oc5hI1pyHGmb8F4UdEaWQ8qR38iD0R0furVD_3Ag8wRuQMcVdAsOO5IW65c5s&_nc_ht=scontent-tpe1-1.xx&oh=b97782923c72a7d4dda4d29efece14c0&oe=5DFE8FDC'),
              ),
            ),
            Divider(
              color: Colors.blue[700],
              height: 40.0,
            ),
            Text(
              '名稱',
              style: TextStyle(
                color: Colors.grey[300],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Yanwei Liu',
              style: TextStyle(
                color: Colors.amberAccent[200],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '地點',
              style: TextStyle(
                color: Colors.grey[300],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '高雄',
              style: TextStyle(
                color: Colors.amberAccent[200],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '研究領域',
              style: TextStyle(
                color: Colors.grey[300],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'ML&DL / Front End/ Web Scraping',
              style: TextStyle(
                color: Colors.amberAccent[200],
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'e96031413@hotmail.com',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}