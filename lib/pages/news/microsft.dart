import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Microsoft extends StatefulWidget {
  const Microsoft({Key? key}) : super(key: key);

  @override
  State<Microsoft> createState() => _MicrosoftState();
}

class _MicrosoftState extends State<Microsoft> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text('Office 365 for Students', style: heading,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('11 May 2023, 4:47 PM'),
                      ),
                      SizedBox(
                        height: 230.0,
                        child: Image.asset("assets/office.png", scale: 3.5,),
                      ),
                      Text('INTI is providing Microsoft Office to every student for FREE! '
                          'You will get the latest version of the full Office Productivity Suite, '
                          'which includes Word, Excel, PowerPoint, OneNote, and more. The software is '
                          'available both offline and online and is a great asset to helping you prepare for class.\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('So long as you are a student of INTI, you will be able to use this software '
                          'with absolutely no charge! Here are some of the additional features:'),
                      Text('\n'),
                      Text('- Installs on up to 5 compatible PCs and Ma1cs, plus 5 tablets.'),
                      Text('- Compatible with OneDrive for automatic device syncing'),
                      Text('\n'),
                      Wrap(
                        children: [
                          Text('To get your FREE Office suite visit '),
                          GestureDetector(
                            onTap: () {
                              _launchURL("microsoft.com");
                            },
                              child: Text('Office.com/GetOffice365',
                                style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue[700]),
                              ),
                          ),
                          Text('and follow the guide below to register and download the software. You will need your'),
                          Text('INTI', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(' Student Email account', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(' to register for Microsoft'),
                          Text('Office.'),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
