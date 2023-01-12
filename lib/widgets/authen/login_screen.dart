import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockolio/bloc/login/login_bloc.dart';
import 'package:stockolio/bloc/login/login_event.dart';
import 'package:stockolio/bloc/login/login_state.dart';
import 'package:stockolio/bloc/state_status.dart';
import 'package:stockolio/di/service_injection.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/model/authen/login_request.dart';
import 'package:stockolio/router/router.gr.dart';
import 'package:stockolio/shared/colors.dart';
import 'package:stockolio/widgets/common/button_utilities.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[buildLoginPage(), buildSignupPage()],
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildLoginPage() {
    return BlocProvider(
      create: (BuildContext context) => getIt<LoginBloc>(),
      child: Form(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // LOGO
            Container(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Icon(
                  Icons.bar_chart,
                  color: Colors.green[800],
                  size: 50.0,
                ),
              ),
            ),
            // NAME
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "FINOCIO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            // EMAIL INPUT
            _buildInputLabel('EMAIL'),
            _buildInput(
                hintText: 'jonhdoe@gmail.com',
                controller: _emailController,
                inputType: InputType.user_name,
                validatorCallback: _validateUserName),

            SizedBox(
              height: 14.0,
            ),
            // PASSWORD INPUT
            _buildInputLabel('PASSWORD'),
            _buildInput(
                hintText: '*********',
                controller: _passwordController,
                inputType: InputType.password),

            // Divider(
            //   height: 24.0,
            // ),
            // FORGOT PASSWORD
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            _buildButton(
                btnLabel: 'LOGIN',
                callback: () {
                  getIt<LoginBloc>().add(
                    LoginButtonClick(
                      request: LoginRequest(
                        userName: _emailController.text,
                        password: _passwordController.text,
                      ),
                    ),
                  );
                }),
            _buildButton(
                btnLabel: 'SIGN UP',
                callback: () {
                  _controller.animateToPage(
                    1,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.bounceOut,
                  );
                }),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  "OR CONNECT WITH",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // SOCIAL LOGIN BUTTON
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) {
                  return current.source == LoginSource.GOOGLE ||
                      current.source == LoginSource.FACEBOOK;
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      _buildSocialButton(
                        bgColor: Color(0Xffdb3236),
                        context: context,
                        icon: FontAwesomeIcons.google,
                        isLoading: state.status == BlocStateStatus.loading,
                        source: LoginSource.GOOGLE,
                      ),
                      _buildSocialButton(
                        bgColor: Color(0Xff3B5998),
                        context: context,
                        icon: FontAwesomeIcons.facebook,
                        isLoading: state.status == BlocStateStatus.loading,
                        source: LoginSource.FACEBOOK,
                      )
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.status == LoginStatus.loading) {
                  return Center(
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  if (state.status == BlocStateStatus.success)
                    AutoRouter.of(context).push(StockolioAppHomeRoute());
                  return Center(
                    child: TextButton(
                      child: Text(
                        "Later",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      onPressed: () => {
                        BlocProvider.of<LoginBloc>(context).add(
                          AnonymousLogin(),
                        ),
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildInputLabel(String lblText) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text(
          lblText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  _buildInput(
      {String? hintText,
      TextEditingController? controller,
      InputType? inputType,
      String? Function(String?)? validatorCallback}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.white, width: 0.5, style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        textAlign: TextAlign.left,
        validator: validatorCallback,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          // errorText: _errorText(controller, inputType),
        ),
      ),
    );
  }

  String? _validateUserName(String? value) {
    // Note: you can do your own custom validation here
    var text = _emailController.value.text;
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }

    if (EmailValidator.validate(text)) {
      return 'Email not valid!';
    }
    // return null if the text is valid
    return null;
  }

  String? _validatePassword(String? value) {
    // at any time, we can get the text from _controller.value.text
    final text = value!;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }

    if (EmailValidator.validate(text)) {
      return 'Email not valid!';
    }
    // return null if the text is valid
    return null;
  }

  String? _errorText(TextEditingController _controller, InputType inputType) {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }

    switch (inputType) {
      case InputType.user_name:
      case InputType.email:
        if (EmailValidator.validate(text)) {
          return 'Email not valid!';
        }
        break;
      case InputType.password:
        break;
      case InputType.confirm_password:
        break;
      default:
    }
    // return null if the text is valid
    return null;
  }

  _onSocialButtonClick(BuildContext context, String source) {
    switch (source) {
      case LoginSource.GOOGLE:
        BlocProvider.of<LoginBloc>(context).add(LoginWithGoogle());
        break;
      case LoginSource.FACEBOOK:
        BlocProvider.of<LoginBloc>(context).add(LoginWithFacebook());
        break;
      default:
    }
  }

  _buildSocialButton({
    required BuildContext context,
    required String source,
    required Color bgColor,
    required bool isLoading,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            if (!isLoading) _onSocialButtonClick(context, source);
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: bgColor,
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      isLoading
                          ? Container(
                              height: 20.0,
                              width: 20.0,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : FaIcon(
                              icon,
                              size: 20.0,
                              color: Colors.white,
                            ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        source,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildButton({required String btnLabel, VoidCallback? callback}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          ButtonUltilities(
            buttonCommand: ButtonCommand.TEXT_BUTTON,
            buttonText: btnLabel,
            backgroundColor: Colors.green[800]!,
            textColor: Colors.white,
            isLoadingButton: false,
            onButtonPressed: callback ?? () {},
          ),
        ],
      ),
    );
  }

  Widget buildSignupPage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(100.0),
              child: Center(
                child: Icon(
                  Icons.headset_mic,
                  color: Colors.green[800],
                  size: 50.0,
                ),
              ),
            ),
            _buildInputLabel('EMAIL'),
            _buildInput(
                hintText: 'cuongtv@gmail.com',
                controller: _emailController,
                inputType: InputType.user_name),
            SizedBox(
              height: 14.0,
            ),
            // PASSWORD INPUT
            _buildInputLabel('PASSWORD'),
            _buildInput(
                hintText: '*********',
                controller: _passwordController,
                inputType: InputType.password),
            SizedBox(
              height: 14.0,
            ),
            // PASSWORD INPUT
            _buildInputLabel('CONFIRM PASSWORD'),
            _buildInput(
                hintText: '*********',
                controller: _confirmPasswordController,
                inputType: InputType.confirm_password),
            SizedBox(
              height: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.green[800],
                      ),
                      onPressed: () => {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
