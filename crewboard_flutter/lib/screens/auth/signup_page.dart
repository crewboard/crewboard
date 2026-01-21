import 'dart:async';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';
import 'package:crewboard_flutter/main.dart'; // For client
import 'signin_page.dart';
import 'widgets.dart';
import '../../config/palette.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _organizationIdController = TextEditingController();

  bool _isLoading = false;
  String? _successMessage;
  String? _errorMessage;
  String _signupType = 'organization'; // 'organization' or 'self-hosting'

  // ignore: unused_field
  Timer? _debounceTimer;
  bool _isCheckingOrganization = false;
  bool _organizationValid = false;
  String? _organizationError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _organizationNameController.dispose();
    _organizationIdController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onOrganizationNameChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _checkOrganization();
    });
  }

  Future<void> _checkOrganization() async {
    final name = _organizationNameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _organizationError = 'Please enter organization name';
        _organizationValid = false;
      });
      return;
    }

    setState(() {
      _isCheckingOrganization = true;
      _organizationError = null;
      _organizationValid = false;
    });

    try {
      final response = await client.auth.checkOrganization(name);
      setState(() {
        if (response.exists) {
          _organizationError = 'Organization name already exists';
          _organizationValid = false;
        } else {
          _organizationValid = true;
          _organizationError = null;
        }
        _isCheckingOrganization = false;
      });
    } catch (e) {
      setState(() {
        _organizationError = 'Failed to check organization name';
        _isCheckingOrganization = false;
        _organizationValid = false;
      });
    }
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });
    try {
      final generatedEmail =
          '${_usernameController.text.trim().toLowerCase()}@local.local';

      final response = await client.auth.registerAdmin(
        generatedEmail,
        _usernameController.text.trim(),
        _passwordController.text,
        _signupType,
        _signupType == 'organization'
            ? _organizationNameController.text.trim()
            : null,
        _signupType == 'self-hosting'
            ? UuidValue.fromString(_organizationIdController.text)
            : null,
      );

      if (response.success ||
          (response.message == 'Username already exists' ||
              response.message == 'Email already exists' ||
              response.message == 'User already exists')) {
        setState(() {
          _successMessage = response.success
              ? response.message
              : 'User already exists';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration failed: ${e.toString()}';
        _isLoading = false;
      });
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
          // Window title bar with close, maximize, minimize buttons
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
            child: Obx(() => Row(
              children: [
                MinimizeWindowButton(colors: Pallet.windowButtonColors),
                MaximizeWindowButton(colors: Pallet.windowButtonColors),
                CloseWindowButton(colors: Pallet.closeWindowButtonColors),
              ],
            )),
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
                  'Sign Up',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to sign in
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
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
              'Create an account to get started with CrewBoard.',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: const Color(0xFF7F8C8D),
              ),
            ),
            const SizedBox(height: 32),

            // Messages
            AuthMessage(message: _errorMessage, isError: true),
            AuthMessage(message: _successMessage, isError: false),

            // Signup Type Selection
            const SizedBox(height: 16),
            Text(
              'Choose Signup Type',
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
                      style: TextStyle(fontSize: 13),
                    ),
                    value: 'organization',
                    // ignore: deprecated_member_use
                    groupValue: _signupType,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _signupType = value!;
                      });
                    },
                    activeColor: const Color(0xFF3498DB),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text(
                      'Self Hosting',
                      style: TextStyle(fontSize: 13),
                    ),
                    value: 'self-hosting',
                    // ignore: deprecated_member_use
                    groupValue: _signupType,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _signupType = value!;
                      });
                    },
                    activeColor: const Color(0xFF3498DB),
                  ),
                ),
              ],
            ),

            // Organization Name Field (only show if organization is selected)
            if (_signupType == 'organization') ...[
              const SizedBox(height: 20),
              AuthInputField(
                controller: _organizationNameController,
                label: 'Organization Name',
                icon: Icons.business,
                onChanged: _onOrganizationNameChanged,
                errorText: _organizationError,
                suffixIcon: _isCheckingOrganization
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : _organizationNameController.text.isNotEmpty &&
                          !_isCheckingOrganization
                    ? Icon(
                        _organizationValid ? Icons.check_circle : Icons.error,
                        color: _organizationValid ? Colors.green : Colors.red,
                      )
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  if (value.length < 2) {
                    return 'Organization name must be at least 2 characters';
                  }
                  if (!_organizationValid) {
                    return 'Please choose a unique organization name';
                  }
                  return null;
                },
              ),
            ],

            // Organization ID Field (only show if self-hosting is selected)
            if (_signupType == 'self-hosting') ...[
              const SizedBox(height: 20),
              AuthInputField(
                controller: _organizationIdController,
                label: 'Organization ID',
                icon: Icons.tag,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization ID';
                  }
                  try {
                    UuidValue.fromString(value);
                  } catch (e) {
                    return 'Please enter a valid UUID';
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
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Sign Up Button
            AuthButton(
              text: 'Sign Up',
              onPressed: _signUp,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
