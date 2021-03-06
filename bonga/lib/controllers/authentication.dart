import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bonga/constants.dart';
import 'package:bonga/controllers/account_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  static Future<bool> registerUser(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        await AccountManagement.createUserDetailsUponAccountCreation(
            emailAddress, user.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Please use a stronger password.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'This email address is already registered');
        return false;
      }
    } catch (e) {
      print(e);
    }

    return true;
  }

  static Future<bool> loginUser(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User does not exist');
        return false;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Incorrect password. Try again');
        return false;
      }
    } catch (e) {
      print(e);
    }

    return true;
  }

  static Future<bool> resetPassword(String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return false;
      } else if (e.code == 'user-not-found') {
        return false;
      }
    }
    return true;
  }

  static Future<bool> deleteUser(BuildContext context) async {
    String? emailAddress;
    String? password;
    try {
      String _userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(_userId)
          .collection('messages')
          .get()
          .then((value) => () {
                value.docs.forEach((element) {
                  element.reference.delete();
                });
              });

      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(_userId)
          .delete();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .delete();

      await FirebaseAuth.instance.currentUser!.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        showTextInputDialog(
          context: context,
          message: 'Please reauthenticate',
          okLabel: 'OK',
          cancelLabel: 'CANCEL',
          textFields: [
            DialogTextField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Address field empty. Please enter an email address';
                }
                if (!kEmailRegExPattern.hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                emailAddress = value;
                return null;
              },
            ),
            DialogTextField(
              hintText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Address field empty. Please enter an email address';
                }
                if (!kPasswordRegExPattern.hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                password = value;
                return null;
              },
            ),
          ],
          title: 'Reauthenticate',
        );
        AuthCredential userAuthCredential = EmailAuthProvider.credential(
            email: emailAddress!, password: password!);

        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(userAuthCredential);

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await FirebaseFirestore.instance
          .collection('rooms')
          .doc(user.uid)
          .collection('messages')
          .get()
          .then((value) => () {
                value.docs.forEach((element) {
                  element.reference.delete();
                });
              });

      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(user.uid)
          .delete();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
          user.delete();
        }
        return true;
      }
    }
    return false;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
