import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class ProgramDetails extends StatefulWidget {
  const ProgramDetails({Key? key}) : super(key: key);

  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(globalSelectedProgram['name'],
                            style: title,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.menu_book_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Business'),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Diploma'),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.access_time_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('2 years'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.attach_money),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('RM 35,097'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Programme Structure', style: heading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- Fundamentals of English\n- Fundamentals of Marketing'),
                          Text('- English for Academic Purpose\n- Principles of Microeconomics'),
                          Text('- Introduction to Business\n- Fundamentals of Management'),
                          Text('- Cost Accounting\n- Public Speaking'),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Intake', style: heading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('January, April, August'),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Career Opportunities', style: heading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- Digital Marketing Specialist\n- E-Business Consultant'),
                          Text('- E-Services Manager\n- E-Business Manager'),
                          Text('- Market Research Analyst\n- Online Business Entrepreneur'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Additional Information', style: heading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('The Diploma in E-Commerce is designed to equip students with up-to-date knowledge and the relavant skills in E-commerce, International Marketing, E-Business Fundamentals, E-marketing and application of internet technology in business.',),
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
