class SignUpFailure {
  final String message;

  const SignUpFailure([this.message = "Your sign-up process failed! :("]);

  factory SignUpFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpFailure('Please enter a stronger password.');
      case 'invalid-email':
        return SignUpFailure('Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return SignUpFailure('An account already exists using that email.');
      default:
        return const SignUpFailure();
    }
  }
}
