import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PTPTN extends StatefulWidget {
  const PTPTN({Key? key}) : super(key: key);

  @override
  State<PTPTN> createState() => _PTPTNState();
}

class _PTPTNState extends State<PTPTN> {
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
      backgroundColor: Colors.white,
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
                    Text('PTPTN Online Application', style: heading,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('01 Apr 2023, 2:42 PM'),
                    ),
                    SizedBox(
                      height: 230.0,
                      child: Image.asset("assets/ptptn.png", scale: 3.5,),
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
                            _launchURL("www.ptptn.gov.my");
                          },
                            child: Text('www.ptptn.gov.my',
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
