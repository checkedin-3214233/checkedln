import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../views/auth/otp_verification.dart';

class FirebaseAuthServices {
  final _auth = FirebaseAuth.instance;
  Future<void> sendOtp(String phoneNumber) async {
    // Send OTP to the phone number
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.rawSnackbar(message: e.code.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.find<AuthController>().verificationId.value = verificationId;
        Get.find<AuthController>().isOtpSent.value = true;
        Get.to(() => OtpVerification());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> veryfyotp(String verificationId, String otp) async {
    if (otp.length == 6) {
      try {
        AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp);
        final authCred = await _auth.signInWithCredential(phoneAuthCredential);
        print(authCred.user);
        return true;
      } on FirebaseAuthException catch (e) {
        Get.rawSnackbar(message: e.code.toString());
      }
    } else {
      Get.rawSnackbar(message: "Invalid Otp");
      return false;
    }
    return false;
  }
}
