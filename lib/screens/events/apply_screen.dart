import 'package:flutter/material.dart';

class ApplicationForm extends StatefulWidget {
  final String eventId;
  final String eventTitle;

  const ApplicationForm({
    super.key,
    required this.eventId,
    required this.eventTitle,
  });

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  String? _selectedDzongkhag;
  String? _selectedGewog;
  String? _selectedVillage;
  String? _contactNumber;
  String? _remarks;
  
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Application'),
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
              // Event Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.dividerColor,
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
                          Icon(Icons.event, color: theme.primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'EVENT DETAILS',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.eventTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${widget.eventId}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              
              // Personal Information Section
              Text(
                'PERSONAL INFORMATION',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: theme.dividerColor),
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
                  prefixIcon: const Icon(Icons.phone_outlined),
                  prefixText: '+975 ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor,
                    ),
                  ),
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
              
              // Remarks
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Additional Remarks (Optional)',
                  prefixIcon: const Icon(Icons.note_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor,
                    ),
                  ),
                ),
                maxLines: 3,
                onSaved: (value) => _remarks = value,
              ),
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 160, 80),
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SUBMIT APPLICATION',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
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
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.dividerColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.dividerColor,
          ),
        ),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: theme.textTheme.bodyMedium,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      dropdownColor: theme.cardColor,
      icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color),
      borderRadius: BorderRadius.circular(12),
      style: theme.textTheme.bodyMedium,
      isExpanded: true,
    );
  }
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Process the form data
      final applicationData = {
        'eventId': widget.eventId,
        'eventTitle': widget.eventTitle,
        'dzongkhag': _selectedDzongkhag,
        'gewog': _selectedGewog,
        'village': _selectedVillage,
        'contactNumber': _contactNumber,
        'remarks': _remarks,
        'submittedAt': DateTime.now().toString(),
      };
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Application Submitted'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thank you for applying to:'),
              const SizedBox(height: 8),
              Text(
                widget.eventTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('We will contact you soon with more details.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close form
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}