# Stream Fluent Validation 


Stream Fluent Validation is a  validation library for Flutter developer . It supports text validation for String, EditText, TextView, AutoCompleteTextView, TextInputLayout, and Spinner. It comes with lots of built-in rules for validation such as email, special character validations and so on. 



## Quick Stream Fluent Validation 

For example, you can validate any Form  like this:

```dart
  final LoginValidation loginValidation = LoginValidation();

class LoginValidation extends AbstractValidator<LoginValidation> {
  StreamValidator<String> email = StreamValidator<String>();
  StreamValidator<String> password = StreamValidator<String>();

  LoginValidation() {
    ruleFor((e) => (e as LoginValidation).email)
        .isNotEmpty()
        .withMessage("email should not be empty")
        .emailAddress()
        .withMessage("email should be valid !!.");

    ruleFor((e) => (e as LoginValidation).password).between(3, 4)  .withMessage("password  should contain from 3 to 4 digit  !!.");
  }
}

// Later on
StreamBuilder(
        stream:loginValidation.email.stream,
        builder: (context, snap) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: loginValidation.email.valueChange,
            decoration: InputDecoration(
                labelText: "Email address",
                hintText: "you@example.com",
                errorText: snap.hasError ? "${snap.error}" : null),
          );
        },
      )
      
      StreamBuilder(
        stream: loginValidation.password.stream,
        builder: (context, snap) {
          return TextField(
            keyboardType: TextInputType.number,
            onChanged:loginValidation.password.valueChange,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "******",
                errorText: snap.hasError ? "${snap.error}" : null),
          );
        },
      );
```

## Multiple Validation Checks wiht message
Stream Fluent Validation  also supports multiple validation checks   like this:

```dart

class LoginValidation extends AbstractValidator<LoginValidation> {
  StreamValidator<String> email = StreamValidator<String>();

  LoginValidation() {
    ruleFor((e) => (e as LoginValidation).email)
        .isNotEmpty()
        .withMessage("email should not be empty")
        .emailAddress()
        .withMessage("email should be valid !!.");

  }
}


```

## Create Your Own Custom Validation Checks
You can also add your own custom by extending use must validator rule.

```dart
   ruleFor((e) => (e as LoginValidation).userName).must((Object value) {
      return value.toString().isNotEmpty &&
          value.toString().contains(".") &&
          value.toString().length >= 3;
    }).withMessage("user name is not correct");
 ```  
 
 ## Built in Validators
* notEmpty - (checks the object is a String and not empty)
* empty - (checks the object is a String and is empty)
* notEqual - (checks if an current stream is not equal to another)
* equal - (checks if an current stream is equal to another)
* notEqualToConstValue - (checks if an value is not equal to another)
* equalToConstValue - (checks if an value is equal to another)
* length - (checks the object is a String and is between two other numbers)

## Extra Built In Validators
These are not included in the default C# version.  
* isValidEmailAddress - (checks the object is a String and is a valid email address)

## Contributing
Feel free to do a pull request with any ideas and I will check each one.
¬ Rad
