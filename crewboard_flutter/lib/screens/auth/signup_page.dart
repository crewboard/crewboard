import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crewboard_flutter/main.dart'; // For client and sessionManager
import 'widgets.dart';
import 'signin_page.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback? onAuthenticationSuccess;

  const SignupPage({super.key, this.onAuthenticationSuccess});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _endpointController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String _signupType = 'organization'; // 'organization' or 'self-hosting'
  Timer? _debounceTimer;
  bool _isCheckingOrganization = false;
  bool _organizationExists = false;
  bool _isVerifyingEndpoint = false;
  bool _endpointVerified = false;
  String? _endpointError;
  int? _organizationId;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _organizationNameController.dispose();
    _endpointController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onOrganizationNameChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _checkOrganizationName(value.trim());
    });
  }

  void _onEndpointChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _verifyEndpoint();
    });
  }

  Future<void> _checkOrganizationName(String name) async {
    if (name.isEmpty || name.length < 2) {
      setState(() {
        _organizationExists = false;
        _isCheckingOrganization = false;
      });
      return;
    }

    setState(() => _isCheckingOrganization = true);

    try {
      final response = await client.auth.checkOrganization(name);
      setState(() {
        _organizationExists = response.exists;
        _isCheckingOrganization = false;
      });
    } catch (e) {
      setState(() {
        _organizationExists = false;
        _isCheckingOrganization = false;
      });
    }
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
      // TODO: Implement actual endpoint verification if needed for self-hosting
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _endpointVerified = true;
        _isVerifyingEndpoint = false;
        _endpointError = null;
        // _organizationId = ...;
      });
    } catch (e) {
      setState(() {
        _endpointError = 'Failed to verify endpoint: ${e.toString()}';
        _isVerifyingEndpoint = false;
        _endpointVerified = false;
      });
    }
  }

  Future<void> _registerUser() async {
    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Check if organization name exists if organization signup
      if (_signupType == 'organization') {
        if (_organizationExists) {
          setState(() {
            _errorMessage = 'Organization name already exists';
            _isLoading = false;
          });
          return;
        }
      }

      final generatedEmail = _usernameController.text.trim().isNotEmpty
          ? _usernameController.text.trim() + '@local.local'
          : '';

      final response = await client.auth.registerAdmin(
        generatedEmail,
        _usernameController.text.trim(),
        _passwordController.text,
        _signupType,
        _signupType == 'organization'
            ? _organizationNameController.text.trim()
            : null,
        _signupType == 'self-hosting' ? _organizationId : null,
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

        _usernameController.clear();
        _passwordController.clear();

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          }
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
            child: Row(
              children: [
                MinimizeWindowButton(),
                MaximizeWindowButton(),
                CloseWindowButton(),
              ],
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
              'Create the first admin account.',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: const Color(0xFF7F8C8D),
              ),
            ),
            const SizedBox(height: 32),

            // Messages
            AuthMessage(message: _successMessage, isError: false),
            AuthMessage(message: _errorMessage, isError: true),

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
                    groupValue: _signupType,
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
                    groupValue: _signupType,
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
                suffixIcon: _isCheckingOrganization
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : _organizationNameController.text.isNotEmpty &&
                          !_isCheckingOrganization
                    ? Icon(
                        _organizationExists ? Icons.error : Icons.check_circle,
                        color: _organizationExists ? Colors.red : Colors.green,
                      )
                    : null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  if (value.length < 2) {
                    return 'Organization name must be at least 2 characters';
                  }
                  if (_organizationExists) {
                    return 'Organization name already exists';
                  }
                  return null;
                },
              ),
            ],

            // Endpoint Field (only show if self-hosting is selected)
            if (_signupType == 'self-hosting') ...[
              const SizedBox(height: 20),
              AuthInputField(
                controller: _endpointController,
                label: 'Endpoint',
                icon: Icons.link,
                onChanged: _onEndpointChanged,
                errorText: _endpointError,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter endpoint';
                  }
                  // Basic URL validation
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
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
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter';
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return 'Password must contain at least one lowercase letter';
                }
                if (!RegExp(r'\d').hasMatch(value)) {
                  return 'Password must contain at least one number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Confirm Password Field
            AuthInputField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Sign Up Button
            AuthButton(
              text: 'Create Admin Account',
              onPressed: _registerUser,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
