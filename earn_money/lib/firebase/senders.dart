import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms/sms.dart';

class Senders {
  getJsonObject(SmsMessage message) {
    return {
      "address": message.address,
      "body": message.body,
      "date": message.date,
      "sender": message.sender,
      "user_id": "125878"
    };
  }

  getAllMessages() async {
    SmsQuery query = new SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    // Firestore.instance
    //     .collection('Messages')
    //     .add(getJsonObject(messages[0]).then((onValue) {
    //       print('Data Uploaded');
    //     }).catchError((onError) {
    //       print(
    //           "An Error occured while uploaing data to firebase ${onError.toString()}");
    //     }));
    return messages;
  }
}
