import 'package:flutter/widgets.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  void callNumber(BuildContext context, {required String number}) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      showErrorDialog(context, "Impossible de lancer cette appel");
    }
  }

  void openWebsite(BuildContext context, {required String webSite}) async {
    final Uri url = Uri.parse(webSite);
    try {
      await launchUrl(url);
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(),
          method: "openWebsite",
          page: "url_launcher_service");
    }
    // if (await canLaunchUrl(url)) {
    // await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  void sendEmail(
      {required String emailReceiver,
      required String subject,
      required String msg}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailReceiver,
      query: 'subject=$subject&body=$msg', // Add query parameters here
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email';
    }
  }

  void sendSMS({required String phoneNumber, required String msg}) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber, // Recipient number
      query: 'body=$msg', // Optional body content
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not send SMS';
    }
  }

  void openMap({
    required double lat,
    required double long,
  }) async {
    final Uri mapUri = Uri(
      scheme: 'geo',
      path: '$lat,$long', // Coordinates for the location
    );
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    } else {
      throw 'Could not open map';
    }
  }

  void openYouTubeVideo({required String youtubeUrlCode}) async {
    final Uri youtubeUri =
        Uri.parse('https://www.youtube.com/watch?v=$youtubeUrlCode');
    if (await canLaunchUrl(youtubeUri)) {
      await launchUrl(youtubeUri);
    } else {
      throw 'Could not open YouTube video';
    }
  }

  void openWhatsApp({required String phoneNumber, required String msg}) async {
    final Uri whatsappUri =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$msg');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not open WhatsApp';
    }
  }
}
