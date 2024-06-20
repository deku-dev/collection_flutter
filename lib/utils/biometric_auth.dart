import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    return canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      authenticated = false;
    }
    return authenticated;
  }
}
