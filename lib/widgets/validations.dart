import 'package:fzregex/fzregex.dart';

import 'package:fzregex/utils/pattern.dart';

validateEmail() {
  Fzregex.hasMatch("name@mail.com", FzPattern.email);
}
