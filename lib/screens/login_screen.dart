  import 'package:flutter/material.dart';
  import 'dashboard_screen.dart'; // Keep this import for MenuName
  import 'announcement_before_login_screen.dart'; // New import
  import 'news_screen.dart'; // New import

  class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _forgotPasswordEmailController = TextEditingController();

  String _errorMessage = '';
  bool _isForgotPasswordScreenVisible = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _forgotPasswordEmailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _forgotPasswordEmailController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _forgotPasswordEmailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (_emailController.text == 'test@gmail.com' && 
          _passwordController.text == 'password') {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const DashboardScreen(),
            transitionsBuilder: (_, a, __, c) => 
            FadeTransition(opacity: a, child: c),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
          _passwordController.clear();
        });
      }
    }
  }

  Future<void> _recoverPassword() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simulate network call

    if (mounted) {
      setState(() => _isLoading = false); // Corrected syntax
      
      if (!_forgotPasswordEmailController.text.contains('@')) {
        setState(() => _errorMessage = 'Please enter a valid email');
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_read,
                    size: 36,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Check Your Email',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'We sent a password reset link to\n${_forgotPasswordEmailController.text}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF718096),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _hideForgotPasswordScreen();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4299E1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Return to Login',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _showForgotPasswordScreen() {
    setState(() {
      _isForgotPasswordScreenVisible = true;
      _errorMessage = '';
    });
  }

  void _hideForgotPasswordScreen() {
    setState(() {
      _isForgotPasswordScreenVisible = false;
      _forgotPasswordEmailController.clear();
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Return an empty container or a basic widget if in password recovery mode
    if (_isForgotPasswordScreenVisible) {
      return Scaffold(
        body: Stack(
          children: [
            // Professional background with subtle gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 236, 190, 130),
                    Color.fromARGB(255, 244, 215, 193),
                  ],
                ),
              ),
            ),

            // Decorative elements with better positioning (optional, can be removed)
            Positioned(
              top: -MediaQuery.of(context).size.width * 0.2,
              right: -MediaQuery.of(context).size.width * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFEBF8FF).withOpacity(0.8),
                      const Color(0xFFEBF8FF).withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(child: Center(child: _buildForgotPasswordForm(theme))),
          ],
        ),
      );
    }
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          // Professional background with subtle gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 236, 190, 130),
                  Color.fromARGB(255, 244, 215, 193),
                ],
              ),
            ),
          ), // Background and decorative elements...
          
          // Decorative elements with better positioning
          Positioned(
            top: -size.width * 0.2,
            right: -size.width * 0.1,
            child: Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFEBF8FF).withOpacity(0.8),
                    const Color(0xFFEBF8FF).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: -size.width * 0.3,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFF0FFF4).withOpacity(0.6),
                    const Color(0xFFF0FFF4).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Simplified logo presentation
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
  child: Image.asset('assets/images/logo.png', height: 80), // Simplified logo
                    ),
                    const SizedBox(height: 48),
                    
                    // Form container with better shadow and border

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _isForgotPasswordScreenVisible
                            ? _buildForgotPasswordForm(theme)
                            : _buildLoginForm(theme),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Text(
                      '© 2025 De-suung. All rights reserved.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Important: remove default padding
          children: <Widget>[ // Use <Widget> to specify the type
            const DrawerHeader( // A standard header for the drawer
              decoration: BoxDecoration(
                color: Color(0xFF4299E1), // Customize header color
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)), // Header text
            ),
            ListTile( // ListTile for the News item
              leading: const Icon(Icons.article), // Icon for News
              title: const Text('News'), // Text for News item
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen())); // Navigate to NewsScreen
              },
            ),
            ListTile( // ListTile for the Announcements item
              leading: const Icon(Icons.announcement), // Icon for Announcements
              title: const Text('Announcements'), // Text for Announcements item
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnnouncementBeforeLoginScreen())); // Navigate to AnnouncementBeforeLoginScreen
              },
            ),
          ], // Ensure you have a closing parenthesis and semicolon for ListView children
        ), // Closing parenthesis for ListView
      ), // Closing parenthesis for Drawer
    );
  }

  Widget _buildLoginForm(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 220, 220),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title with better typography
              Text(
                'Sign In',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A202C),
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue to your account',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF718096),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Error message with improved styling
              if (_errorMessage.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFECACA),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded, 
                        color: Color(0xFFDC2626), size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              
              // Email field with improved styling
              Text(
                'Email Address',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF4A5568),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2D3748),
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFA0AEC0),
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 12),
                    child: Icon(Icons.email_outlined, 
                      size: 20, 
                      color: Color(0xFFA0AEC0)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF4299E1),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Password field with improved styling
              Text(
                'Password',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF4A5568),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2D3748),
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFA0AEC0),
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 12),
                    child: Icon(Icons.lock_outlined, 
                      size: 20, 
                      color: Color(0xFFA0AEC0)),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: Icon(
                        _obscurePassword 
                          ? Icons.visibility_outlined 
                          : Icons.visibility_off_outlined,
                        size: 20,
                        color: const Color(0xFFA0AEC0),
                      ),
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF4299E1),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              
              // Forgot password with better alignment
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _showForgotPasswordScreen,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4299E1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Sign in button with better styling
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4299E1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.transparent,
                  splashFactory: InkRipple.splashFactory,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white),
                        ),
                      )
                    : Text(
                        'Sign In',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              
              // Sign in button
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _hideForgotPasswordScreen,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                Text(
                  'Reset Password',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            Text(
              'Enter the username associated with your account and we\'ll send you a link to reset your password.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 32),
            
            // Error message
            if (_errorMessage.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, 
                      color: Color(0xFFDC2626), 
                      size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Email field
            Text(
              'Username address',
              style: theme.textTheme.labelMedium?.copyWith(
                color: const Color(0xFF4A5568),
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _forgotPasswordEmailController,
              focusNode: _forgotPasswordEmailFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF2D3748),
              ),
              decoration: InputDecoration(
                hintText: 'Enter your username',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFA0AEC0),
                ),
                prefixIcon: const Icon(Icons.email_outlined, 
                  size: 20, 
                  color: Color(0xFFA0AEC0)),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14, horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),
            
            // Submit button
            ElevatedButton(
              onPressed: _isLoading ? null : _recoverPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4299E1),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white),
                      ),
                    )
                  : Text(
                      'Send Reset Link',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
  }