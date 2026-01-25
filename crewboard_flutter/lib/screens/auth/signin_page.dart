import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crewboard_flutter/main.dart'; // For client
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:get/get.dart';
import 'package:crewboard_flutter/controllers/auth_controller.dart';
import 'signup_page.dart';
import 'widgets.dart';
import '../../config/palette.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback? onSignIn;
  const SignInPage({super.key, this.onSignIn});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController =
      TextEditingController(); // Serverpod uses Email usually
  final _passwordController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _endpointController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String _signinType = 'organization'; // 'organization' or 'self-hosting'

  // ignore: unused_field
  Timer? _debounceTimer;
  // ignore: unused_field
  bool _isVerifyingEndpoint = false;
  // ignore: unused_field
  bool _endpointVerified = false;
  String? _endpointError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _organizationNameController.dispose();
    _endpointController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onEndpointChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _verifyEndpoint();
    });
  }

  Future<void> _verifyEndpoint() async {
    final endpoint = _endpointController.text.trim();
    if (endpoint.isEmpty || !Uri.parse(endpoint).isAbsolute) {
      setState(() {
        _endpointError = 'Please enter a valid endpoint URL';
        _endpointVerified = false;
      });
      return;
    }

    setState(() {
      _isVerifyingEndpoint = true;
      _endpointError = null;
      _endpointVerified = false;
    });

    try {
      // TODO: Implement endpoint verification for Serverpod if needed
      // For now, we simulate success if it's a valid URL
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _endpointVerified = true;
        _isVerifyingEndpoint = false;
        _endpointError = null;
      });
    } catch (e) {
      setState(() {
        _endpointError = 'Failed to verify endpoint: ${e.toString()}';
        _isVerifyingEndpoint = false;
        _endpointVerified = false;
      });
    }
  }

  Future<void> _signIn() async {
    try {
      if (_formKey.currentState == null) {
        return;
      }

      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final response = await client.auth
          .simpleLogin(
            _usernameController.text.trim(),
            _passwordController.text,
          )
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              throw Exception('Login timed out.');
            },
          );

      if (!response.success) {
        throw Exception(response.message);
      }

      if (response.authKeyId != null && response.authToken != null) {
        final authUserId = response.userId != null
            ? UuidValue.fromString(response.userId!)
            : UuidValue.fromString(response.authKeyId!.toString());

        final authSuccess = AuthSuccess(
          authStrategy: 'session',
          token: response.authToken!,
          authUserId: authUserId,
          scopeNames: <String>{},
        );

        await sessionManager.updateSignedInUser(authSuccess);

        // Manually set authenticated state to trigger navigation
        final authController = Get.find<AuthController>();
        authController.forceAuthenticated();

        widget.onSignIn?.call();
      } else {
        throw Exception('No auth key received from server');
      }
    } catch (e, stack) {
      print('STACK: $stack');
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      body: Stack(
        children: [
          // 1. Main UI
          SizedBox(
            width: width,
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Image.asset("assets/vector.png"),
                    ),
                  ),
                ),
                AuthFormContainer(child: _buildForm()),
              ],
            ),
          ),

          // 2. Window controls (always on top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              color: Colors.transparent,
              child: MoveWindow(),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Obx(
              () => Row(
                children: [
                  MinimizeWindowButton(colors: Pallet.windowButtonColors),
                  MaximizeWindowButton(colors: Pallet.windowButtonColors),
                  CloseWindowButton(colors: Pallet.closeWindowButtonColors),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign up
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.lato(
                      color: const Color(0xFF3498DB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back! Please sign in to your account.',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: const Color(0xFF7F8C8D),
              ),
            ),
            const SizedBox(height: 32),

            // Messages
            AuthMessage(message: _errorMessage, isError: true),

            // Signin Type Selection
            const SizedBox(height: 16),
            Text(
              'Choose Signin Type',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text(
                      'Organization',
                      style: TextStyle(fontSize: 15),
                    ),
                    value: 'organization',
                    // ignore: deprecated_member_use
                    groupValue: _signinType,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _signinType = value!;
                      });
                    },
                    activeColor: const Color(0xFF3498DB),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text(
                      'Self Hosting',
                      style: TextStyle(fontSize: 15),
                    ),
                    value: 'self-hosting',
                    // ignore: deprecated_member_use
                    groupValue: _signinType,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _signinType = value!;
                      });
                    },
                    activeColor: const Color(0xFF3498DB),
                  ),
                ),
              ],
            ),

            // Organization Name Field (only show if organization is selected)
            if (_signinType == 'organization') ...[
              const SizedBox(height: 20),
              AuthInputField(
                controller: _organizationNameController,
                label: 'Organization Name',
                icon: Icons.business,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  if (value.length < 2) {
                    return 'Organization name must be at least 2 characters';
                  }
                  return null;
                },
              ),
            ],

            // Endpoint Field (only show if self-hosting is selected)
            if (_signinType == 'self-hosting') ...[
              const SizedBox(height: 20),
              AuthInputField(
                controller: _endpointController,
                label: 'Endpoint',
                icon: Icons.link,
                onChanged: _onEndpointChanged,
                errorText: _endpointError,
                suffixIcon: _isVerifyingEndpoint
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : _endpointController.text.isNotEmpty &&
                          !_isVerifyingEndpoint
                    ? Icon(
                        _endpointVerified ? Icons.check_circle : Icons.error,
                        color: _endpointVerified ? Colors.green : Colors.red,
                      )
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter endpoint';
                  }
                  // Basic URL validation
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  if (!_endpointVerified) {
                    return 'Please verify the endpoint';
                  }
                  return null;
                },
              ),
            ],

            // Username Field
            const SizedBox(height: 20),
            AuthInputField(
              controller: _usernameController,
              label: 'Username',
              icon: Icons.person_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Password Field
            AuthInputField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outlined,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Sign In Button
            AuthButton(
              text: 'Sign In',
              onPressed: _signIn,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
