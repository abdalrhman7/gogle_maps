import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    emit(ErrorOccurred(errorMsg: error.toString()));
    print('verificationFailed : ${error.toString()}');
  }

  void codeSent(String verificationId, int? resendToken) {
    print('CodeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential)async{
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    }catch(error){
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut () async{
    await FirebaseAuth.instance.signOut();
}

User getLoggedInUser(){
  User firebaseUser  = FirebaseAuth.instance.currentUser!;
  return firebaseUser;
}
}
