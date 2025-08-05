import 'package:flutter/material.dart';

class ApplySkillingProgram extends StatefulWidget {
  final String programId;
  final String programTitle;

  const ApplySkillingProgram({
    super.key,
    required this.programId,
    required this.programTitle,
  });

  @override
  State<ApplySkillingProgram> createState() => _ApplySkillingProgramState();
}

class _ApplySkillingProgramState extends State<ApplySkillingProgram> {
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  String? _selectedDzongkhag;
  String? _selectedGewog;
  String? _selectedVillage;
  String? _contactNumber;
  String? _educationLevel;
  String? _previousExperience;
  String? _reasonForJoining;
  
  // Sample data for dropdowns
  final List<String> dzongkhags = [
    'Thimphu', 'Paro', 'Punakha', 'Wangdue', 'Bumthang', 
    'Trashigang', 'Mongar', 'Samdrup Jongkhar', 'Trongsa',
    'Zhemgang', 'Sarpang', 'Tsirang', 'Dagana', 'Pema Gatshel',
    'Samtse', 'Haa', 'Gasa', 'Lhuntse', 'Trashi Yangtse',
  ];
  
  final Map<String, List<String>> gewogsByDzongkhag = {
    'Thimphu': ['Chang', 'Kawang', 'Lingzhi', 'Mewang', 'Naro', 'Soe'],
    'Paro': ['Doga', 'Dopshari', 'Doteng', 'Hungrel', 'Lamgong', 'Naja'],
    'Punakha': ['Barp', 'Chhubu', 'Goenshari', 'Guma', 'Kabisa', 'Toewang'],
  };
  
  final Map<String, List<String>> villagesByGewog = {
    'Chang': ['Chang Bangdu', 'Chang Gidaphu', 'Chang Jalu', 'Chang Tagthokha'],
    'Kawang': ['Kawang Babesa', 'Kawang Chari', 'Kawang Drukgyel', 'Kawang Taba'],
  };

  final List<String> educationLevels = [
    'Class VI or below',
    'Class VII-VIII',
    'Class IX-X',
    'Class XI-XII',
    'Diploma',
    'Bachelor\'s degree or higher'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Program'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Program Info Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school_outlined, 
                              color: theme.colorScheme.primary, 
                              size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'PROGRAM DETAILS',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.programTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${widget.programId}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Personal Information Section
              const Text(
                'PERSONAL INFORMATION',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 16),
              
              // Dzongkhag Dropdown
              _buildDropdownField(
                context: context,
                label: 'Dzongkhag',
                value: _selectedDzongkhag,
                items: dzongkhags,
                onChanged: (value) {
                  setState(() {
                    _selectedDzongkhag = value;
                    _selectedGewog = null;
                    _selectedVillage = null;
                  });
                },
                validator: (value) => value == null ? 'Please select your dzongkhag' : null,
                icon: Icons.location_city_outlined,
              ),
              const SizedBox(height: 20),
              
              // Gewog Dropdown
              if (_selectedDzongkhag != null && gewogsByDzongkhag.containsKey(_selectedDzongkhag))
                _buildDropdownField(
                  context: context,
                  label: 'Gewog',
                  value: _selectedGewog,
                  items: gewogsByDzongkhag[_selectedDzongkhag]!,
                  onChanged: (value) {
                    setState(() {
                      _selectedGewog = value;
                      _selectedVillage = null;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your gewog' : null,
                  icon: Icons.map_outlined,
                ),
              if (_selectedDzongkhag != null && gewogsByDzongkhag.containsKey(_selectedDzongkhag))
                const SizedBox(height: 20),
              
              // Village Dropdown
              if (_selectedGewog != null && villagesByGewog.containsKey(_selectedGewog))
                _buildDropdownField(
                  context: context,
                  label: 'Village',
                  value: _selectedVillage,
                  items: villagesByGewog[_selectedGewog]!,
                  onChanged: (value) {
                    setState(() {
                      _selectedVillage = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your village' : null,
                  icon: Icons.home_outlined,
                ),
              if (_selectedGewog != null && villagesByGewog.containsKey(_selectedGewog))
                const SizedBox(height: 20),
              
              // Contact Number
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter your 8-digit mobile number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  prefixText: '+975 ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  if (value.length != 8) {
                    return 'Contact number must be 8 digits';
                  }
                  return null;
                },
                onSaved: (value) => _contactNumber = value,
              ),
              const SizedBox(height: 20),
              
              // Education Level
              _buildDropdownField(
                context: context,
                label: 'Highest Education Level',
                value: _educationLevel,
                items: educationLevels,
                onChanged: (value) {
                  setState(() {
                    _educationLevel = value;
                  });
                },
                validator: (value) => value == null ? 'Please select your education level' : null,
                icon: Icons.school_outlined,
              ),
              const SizedBox(height: 20),
              
              // Previous Experience
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Previous Experience (if any)',
                  hintText: 'Describe any relevant experience you have',
                  prefixIcon: const Icon(Icons.work_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                maxLines: 2,
                onSaved: (value) => _previousExperience = value,
              ),
              const SizedBox(height: 20),
              
              // Reason for Joining
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Why do you want to join this program?',
                  hintText: 'Explain your motivation for joining this program',
                  prefixIcon: const Icon(Icons.note_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please explain why you want to join';
                  }
                  return null;
                },
                onSaved: (value) => _reasonForJoining = value,
              ),
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEBA050),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SUBMIT APPLICATION',
                    style: TextStyle(
                      fontSize: 16,
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

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required String? Function(String?)? validator,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,  // Ensure text is visible
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      dropdownColor: Colors.white,  // Light background for dropdown items
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
      borderRadius: BorderRadius.circular(8),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,  // Ensure selected value is visible
      ),
      isExpanded: true,
      menuMaxHeight: 300,  // Limit dropdown height
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((String item) {
          return Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,  // Ensure selected value is visible
              fontWeight: FontWeight.w500,
            ),
          );
        }).toList();
      },
    );
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Process the form data
      final applicationData = {
        'programId': widget.programId,
        'programTitle': widget.programTitle,
        'dzongkhag': _selectedDzongkhag,
        'gewog': _selectedGewog,
        'village': _selectedVillage,
        'contactNumber': _contactNumber,
        'educationLevel': _educationLevel,
        'previousExperience': _previousExperience,
        'reasonForJoining': _reasonForJoining,
        'submittedAt': DateTime.now().toString(),
      };
      
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              SizedBox(height: 16),
              Text('Application Submitted'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thank you for applying to:'),
              const SizedBox(height: 8),
              Text(
                widget.programTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'We will review your application and contact you soon with further details.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Close form
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEBA050),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      );
    }
  }
}