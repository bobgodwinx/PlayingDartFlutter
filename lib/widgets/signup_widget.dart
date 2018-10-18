import 'package:address_book/models/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef SignupHandler = void Function(String email, String password);

class SignUpWidget extends StatefulWidget {
  final SignupHandler onSignupPressed;

  SignUpWidget({Key key, this.onSignupPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupScreenState(onSignupPressed);
}

enum Pages { email, password, createAccount }

class _SignupScreenState extends State<SignUpWidget>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _signupFocusNode = FocusNode();
  final int _pageCount = 4;
  final Duration slideDuration = Duration(milliseconds: 500);

  Pages _currentPage = Pages.email;

  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  String passwordValidator(String item) =>
      item.isEmpty ? "Password is empty" : null;

  String emailValidator(String item) => item.isEmpty ? "Email is empty" : null;

  final UserCredentials userCredentials = UserCredentials();

  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  SignupHandler onSignupPressed;

  _SignupScreenState(SignupHandler handler) {
    onSignupPressed = handler;
    _pageController.addListener(pageListener);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _signupFocusNode.dispose();
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    if (_currentPage.index == 0) {
      return false;
    }
    _previous();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(100)),
      child: Column(
        children: [
          _buildPageView(),
        ],
      ),
    );
  }

  void _onSubmitEmail() {
    if (_emailKey.currentState.validate()) {
      userCredentials.email = _emailKey.currentState.value;
      _next();
    }
  }

  void _onSubmitPassword() {
    if (_passwordKey.currentState.validate()) {
      userCredentials.password = _passwordKey.currentState.value;
      _next();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _next() {
    _pageController.nextPage(
      duration: slideDuration,
      curve: Curves.easeInOut,
    );
    _currentPage = Pages.values[_currentPage.index + 1];
  }

  void _previous() {
    _pageController.previousPage(
      duration: slideDuration,
      curve: Curves.easeInOut,
    );

    _currentPage = Pages.values[_currentPage.index - 1];
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        itemBuilder: (context, index) {
          return child(index);
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _pageCount,
      ),
    );
  }

  Widget _body(int index) {
    Widget content;

    switch (Pages.values[index]) {
      case Pages.password:
        content = _passwordPage();
        break;
      case Pages.email:
        content = _emailPage();
        break;
      case Pages.createAccount:
        content = _createAccountPage();
        break;
    }

    return content;
  }

  Widget _createAccountPage() => Column(
        children: <Widget>[
          Text("Create an account"),
          RaisedButton(
            child: Text('Sign Up'),
            onPressed: _onSignUp,
          )
        ],
      );

  Widget _emailPage() => Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            key: _emailKey,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            decoration: InputDecoration(
              hintText: 'email',
            ),
          ),
          RaisedButton(
            child: Text('Next'),
            onPressed: _onSubmitEmail,
          )
        ],
      );

  Widget _passwordPage() {
    return Column(children: [
      TextFormField(
        controller: _passwordController,
        key: _passwordKey,
        focusNode: _passwordFocusNode,
        validator: passwordValidator,
        decoration: InputDecoration(
          hintText: 'password',
        ),
      ),
      RaisedButton(
        child: Text('Next'),
        onPressed: _onSubmitPassword,
      )
    ]);
  }

  Widget child(int i) {
    _currentPage = Pages.values[i];
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: _body(i),
    );
  }

  void _onSignUp() {
    onSignupPressed(userCredentials.email, userCredentials.password);
  }

  void pageListener() {
    if (_pageController.page.floor() == _pageController.page.ceil()) {
      switch (Pages.values[_pageController.page.floor()]) {
        case Pages.email:
          _emailController.text = userCredentials.email;
          FocusScope.of(context).requestFocus(_emailFocusNode);
          break;
        case Pages.password:
          _passwordController.text = userCredentials.password;
          FocusScope.of(context).requestFocus(_passwordFocusNode);
          break;
        case Pages.createAccount:
          FocusScope.of(context).requestFocus(_signupFocusNode);
      }
    }
  }
}
