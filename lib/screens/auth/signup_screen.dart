import 'dart:ui';
import 'package:flutter/material.dart';
import 'storage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole = 'Client';
  final _storage = SecureStorageService();
  bool _isSigningUp = false;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSigningUp = true);

      await _storage.saveUserData(
        username: _usernameController.text.trim(),
        name: _nameController.text.trim(),
        age: _ageController.text.trim(),
        role: _selectedRole!,
        password: _passwordController.text.trim(),
      );

      setState(() => _isSigningUp = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful! Please login.')),
      );
      Navigator.pop(context); // Go back to login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/t3.jpg', fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _usernameController,
                            cursorColor: Colors.black87,
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              labelText: 'User ID',
                              labelStyle: const TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black87),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) => value!.isEmpty ? 'Please enter a User ID' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nameController,
                            cursorColor: Colors.black87,
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black87),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _ageController,
                            cursorColor: Colors.black87,
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle: const TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black87),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) => value!.isEmpty ? 'Please enter your age' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            cursorColor: Colors.black87,
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black87),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            dropdownColor: Colors.white,
                            style: const TextStyle(color: Colors.black87),
                            items: ['Client', 'Admin'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: Colors.black87)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Role',
                              labelStyle: const TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black87),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSigningUp ? null : _signup,
                              child: _isSigningUp
                                  ? const CircularProgressIndicator()
                                  : const Text('Signup'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
