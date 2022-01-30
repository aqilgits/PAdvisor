import 'package:flutter/material.dart';

class Advisor extends StatefulWidget {
  const Advisor({Key? key}) : super(key: key);

  @override
  _AdvisorState createState() => _AdvisorState();
}

class _AdvisorState extends State<Advisor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text(
                  "Advisor",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                shadowColor: Colors.red[100],
                color: Colors.red[900],
                child: SizedBox(
                  width: 350,
                  height: 500,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red[200],
                                radius: 108,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://raw.githubusercontent.com/zeshanghayoomi/flutter_user_profile_avatar/master/repo_assets/1.png"), //NetworkImage
                                  radius: 100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Ng Keng Yap',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                '______________________________________________',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            SizedBox(height: 10),
                            Text(
                              'Room Number',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Department',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
