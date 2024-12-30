import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class FeedbackFormScreen extends StatefulWidget {
  @override
  _FeedbackFormScreenState createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _phone, _gender, _country, _state, _city;
  final _phoneRegex = RegExp(r'^\d{10}$');
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool _isSubmitted = false; // To control showing the blue tick

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue[700]),
      labelStyle: TextStyle(color: Colors.blue[900]),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue[200]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red[300]!, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red[700]!, width: 2),
      ),
      filled: true,
      fillColor: Colors.blue[50],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
        title: Text(
          'Feedback Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isSubmitted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.blue[700],
                    size: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Form Submitted Successfully',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue[50]!, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: _buildInputDecoration('Name', Icons.person),
                          validator: (value) => value?.trim().isEmpty ?? true
                              ? 'Name is required'
                              : null,
                          onSaved: (value) => _name = value?.trim(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: _buildInputDecoration('Email', Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Email is required';
                            }
                            if (!_emailRegex.hasMatch(value!)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value?.trim(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: _buildInputDecoration('Phone', Icons.phone),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Phone number is required';
                            }
                            if (!_phoneRegex.hasMatch(value!)) {
                              return 'Enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                          onSaved: (value) => _phone = value?.trim(),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: _buildInputDecoration('Gender', Icons.person_outline),
                          items: ['Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => _gender = value),
                          validator: (value) =>
                              value == null ? 'Please select a gender' : null,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: _buildInputDecoration('Country', Icons.public),
                          validator: (value) => value?.trim().isEmpty ?? true
                              ? 'Country is required'
                              : null,
                          onSaved: (value) => _country = value?.trim(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: _buildInputDecoration('State', Icons.location_on),
                          validator: (value) =>
                              value?.trim().isEmpty ?? true ? 'State is required' : null,
                          onSaved: (value) => _state = value?.trim(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: _buildInputDecoration('City', Icons.location_city),
                          validator: (value) =>
                              value?.trim().isEmpty ?? true ? 'City is required' : null,
                          onSaved: (value) => _city = value?.trim(),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // Display the blue tick for 3 seconds
                              setState(() {
                                _isSubmitted = true;
                              });
                              Timer(Duration(seconds: 3), () {
                                setState(() {
                                  _isSubmitted = false;
                                });
                                _formKey.currentState!.reset(); // Reset the form
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
