import 'package:flutter/material.dart';
import 'package:todo1/shared/network/local/components.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncher extends StatefulWidget {
  const URLLauncher({Key? key}) : super(key: key);

  @override
  State<URLLauncher> createState() => _URLLauncherState();
}

class _URLLauncherState extends State<URLLauncher> {
  final Uri _url =
      Uri.parse('https://www.facebook.com/profile.php?id=100039248505708');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url,
      mode: LaunchMode.inAppWebView,)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _launchUrlSeparate() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_url';
    }
  }

  String phoneNumber = '+201094157080';
  final Uri _urlCall = Uri.parse('tel:+201094157080');

  Future<void> _launchUrlCall() async {
    if (!await launchUrl(_urlCall)) {
      throw 'Could not launch $_urlCall';
    }
  }

  final Uri _urlSMS = Uri.parse('sms:+201094157080');

  Future<void> _launchUrlSMS() async {
    if (!await launchUrl(_urlSMS)) {
      throw 'Could not launch $_urlSMS';
    }
  }

  final Uri _urlEmail = Uri.parse('mailto:osamaelngar98@gmail.com');

  Future<void> _launchUrlEmail() async {
    if (!await launchUrl(_urlEmail)) {
      throw 'Could not launch $_urlEmail';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.yellow,
              onPressed: _launchUrl,
              child: const Text('url Launcher'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              color: Colors.yellow,
              onPressed: _launchUrlCall,
              child: const Icon(
                Icons.call,
                size: 40.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              color: Colors.yellow,
              onPressed: _launchUrlSMS,
              child: const Icon(
                Icons.sms,
                size: 40.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              color: Color(0xfff44336),
              onPressed: _launchUrlEmail,
              child: const Icon(
                Icons.email,
                size: 40.0,
              ),
            ),
            // MaterialButton(
            //   color: Colors.yellow,
            //   onPressed: () {
            //     showBottomSheet(
            //       context: context,
            //       builder: (context) => Container(
            //         height: 300,
            //         color: Colors.indigo,
            //         child: TextFormField(
            //           onTap: _launchUrlEmail,
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Icon(
            //     Icons.email,
            //     size: 40.0,
            //   ),
            // ),
            const SizedBox(
              height: 30.0,
            ),
            MaterialButton(
              color: Colors.yellow,
              onPressed: _launchUrlSeparate,
              child: const Text('url Launcher Separate'),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          generateToken();
        },
        child: const Icon(
          Icons.add,
          size:30.0,
        ),
      ),
    );
  }
}
