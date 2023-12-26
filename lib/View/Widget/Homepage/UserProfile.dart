import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.1,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width * 0.15,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      'Nama : Sudjatmiko',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NIK : 2210191025',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                        Text(
                          'Operasional : Surabaya',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                        Text(
                          'Email : Sudajtmiko@gmail.com',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                        Text(
                          'Telpon : 082121889087',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
