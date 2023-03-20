import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:spacetools/Model/wallet.dart';
import '../main_page.dart';
import '../provider/app_provider.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset('assets/Background.png'),
          RotatedBox(
            quarterTurns: 45,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  const Color(0xFF010187).withOpacity(.4),
                  const Color(0xFFC41BFF),
                ],
              )),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Want to try the demo?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomForm(
                          formKey: formKey,
                          controller: controller,
                          mounted: mounted),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 18,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Row(
                  //     children: const [
                  //       Text(
                  //         'Already a club member?',
                  //         style: TextStyle(fontSize: 16),
                  //       ),
                  //       SizedBox(
                  //         width: 6,
                  //       ),
                  //       Icon(
                  //         Icons.info_outline,
                  //         size: 18,
                  //         color: Colors.blue,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 60,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.blue),
                  //         onPressed: () {},
                  //         child: const Text('LOGIN')),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // SizedBox(
                  //   height: 60,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.black87),
                  //         onPressed: () {},
                  //         child: const Text('Sign up for premium')),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.mounted,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final bool mounted;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late final _formKey;
  bool isLoading = false;
  @override
  void initState() {
    _formKey = widget.formKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter you address';
          } else if (value.characters.length < 32 ||
              value.characters.length > 44) {
            return 'The entered address must be between 32 and 44 characters';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            hintText: '  Enter any Solana or Ethereum address',
            hintStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey.withOpacity(.5),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Consumer<AppProvider>(
                  builder: (context, AppProvider appPro, snapshot) {
                return InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      final SolWalletData _wallet =
                          await appPro.walletData(widget.controller.text);

                      if (appPro.walletCheck == false) {
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }
                      var box = Hive.box('address');
                      await box.clear();
                      box.put('address', widget.controller.text);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                MainPage(address: box.get('address')),
                          ));
                    }
                  },
                  child: !isLoading
                      ? Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: const LinearGradient(colors: [
                                Color(0xFFF533FF),
                                Color(0xFF336CFF),
                                Color(0xFF35D3FF)
                              ])),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.white,
                          ))
                      : const CircularProgressIndicator.adaptive(),
                );
              }),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(.3), width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(.3), width: 2))),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
            child: const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xFFE139FF),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xFF35C9FF),
          ),
        ),
      ],
    );
  }
}
