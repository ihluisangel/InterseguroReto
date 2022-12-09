enum ValidatorsType {
  required,
  email,
  mustMatch,
  minLenght,
  maxLenght,
  date,
  regex
}

class ValidatorsForm {
  final ValidatorsType validator;
  final int? minLenght;
  final int? maxLenght;

  final RegExp? regex;

  final String? macht;

  ValidatorsForm(
      {required this.validator,
      this.maxLenght,
      this.minLenght,
      this.macht,
      this.regex});
  factory ValidatorsForm.required() => ValidatorsForm(
        validator: ValidatorsType.required,
      );
  factory ValidatorsForm.minLeng({required int minLenght}) => ValidatorsForm(
        validator: ValidatorsType.minLenght,
        minLenght: minLenght,
      );
  factory ValidatorsForm.maxLeng({required int maxLenght}) => ValidatorsForm(
        validator: ValidatorsType.maxLenght,
        maxLenght: maxLenght,
      );
  factory ValidatorsForm.email() => ValidatorsForm(
        validator: ValidatorsType.email,
      );
  factory ValidatorsForm.macht({required String macht}) =>
      ValidatorsForm(validator: ValidatorsType.mustMatch, macht: macht);

  factory ValidatorsForm.date() =>
      ValidatorsForm(validator: ValidatorsType.date);

  factory ValidatorsForm.regex({required RegExp regex}) => ValidatorsForm(
        validator: ValidatorsType.regex,
        regex: regex,
      );

// recibo el valor
  bool valid(String? value) {
    bool res = true;
    switch (validator) {
      case ValidatorsType.required:
        if (value == null) {
          res = false;
          break;
        }
        var r = value.replaceAll(" ", '');
        if (r == '') {
          res = false;
        }
        break;
      case ValidatorsType.minLenght:
        if (value == null) {
          res = true;
          break;
        }
        if (value.length < minLenght!) {
          res = false;
        }
        break;
      case ValidatorsType.maxLenght:
        if (value == null) {
          res = true;
          break;
        }

        if (value.length > maxLenght!) {
          res = false;
        }

        break;
      case ValidatorsType.email:
        if (value == null) {
          res = true;
          break;
        }
        if (value == '') {
          res = true;
          break;
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          res = false;
        }
        break;
      case ValidatorsType.mustMatch:
        if (macht != value) {
          res = false;
        }
        break;

      case ValidatorsType.date:
        if (value == null) {
          res = true;
          break;
        }
        if (value == '') {
          res = true;
          break;
        }

        if (!RegExp(
                "/^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02])),\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[1,3-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})\$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))\$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})\$|(?:(?:1[6-9]|[2-9]\\d)?\\d{2})(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\5(?:0?[1-9]|1\\d|2[0-8])\$|^(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\\/|-|\\.)0?2\\6(29)\$|^(?:(?:1[6-9]|[2-9]\\d)?\\d{2})(?:(?:(\\/|-|\\.)(?:0?[1,3-9]|1[0-2])\\8(?:29|30))|(?:(\\/|-|\\.)(?:0?[13578]|1[02])\\9(?:31)))\$/")
            .hasMatch(value)) {
          res = false;
        }
        // valido si es una fecha
        break;
      case ValidatorsType.regex:
        res = regex!.hasMatch(value ?? '');
        break;
      default:
    }

    return res;
  }
}
