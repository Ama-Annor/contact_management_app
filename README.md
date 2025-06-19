# Contact Management App

A modern Flutter mobile application for managing contacts with full CRUD (Create, Read, Update, Delete) operations and real-time API integration.

## 📱 Features

- **Complete Contact Management**: Add, view, edit, and delete contacts
- **Real-time API Integration**: Live data synchronization with remote server
- **Material Design UI**: Clean, intuitive interface with purple theme
- **Form Validation**: Input validation for names and phone numbers
- **Responsive Design**: Optimized for various screen sizes
- **Bottom Navigation**: Easy navigation between different app sections
- **Pull-to-Refresh**: Refresh contact list with simple pull gesture
- **Confirmation Dialogs**: Safe deletion with user confirmation
- **Loading States**: Visual feedback during API operations

## 🖼️ Screenshots

*Add your app screenshots here*

## 🏗️ App Architecture

### Screen Structure
```
Contact Management App
├── Contact List (Home)
├── Add Contact
├── Edit Contact
└── About Screen
```

### Key Components
- **Main Navigation**: Bottom navigation bar with 3 tabs
- **Contact List**: Displays all contacts with edit/delete actions
- **Add Contact**: Form to create new contacts
- **Edit Contact**: Form to update existing contacts
- **About**: App information and developer details

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **HTTP Client**: `http` package for API calls
- **State Management**: StatefulWidget with setState
- **UI Components**: Material Design widgets
- **API**: RESTful API integration

## 📋 Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Physical device or emulator for testing

## ⚡ Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Ama-Annor/contact_management_app.git
cd contact_management_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the Application
```bash
flutter run
```

## 🔧 Configuration

### API Endpoints
The app connects to: `https://apps.ashesi.edu.gh/contactmgt/actions`

### Available API Operations:
- `GET /get_all_contact_mob` - Fetch all contacts
- `GET /get_a_contact_mob?contid={id}` - Fetch single contact
- `POST /add_contact_mob` - Add new contact
- `POST /update_contact` - Update existing contact
- `POST /delete_contact` - Delete contact

## 📱 App Features Detail

### Contact List Screen
- **Display**: Shows all contacts in a scrollable list
- **Actions**: Edit and delete buttons for each contact
- **Refresh**: Pull-down to refresh contact list
- **Avatar**: Displays first letter of contact name
- **Empty State**: Shows message when no contacts exist

### Add Contact Screen
- **Form Fields**: Name and phone number inputs
- **Validation**: 
  - Name: Required field
  - Phone: 10-digit format starting with 0
- **Submit**: Creates new contact via API
- **Feedback**: Success/error messages with colored snackbars

### Edit Contact Screen
- **Pre-populated**: Loads existing contact data
- **Update**: Modifies contact information
- **Navigation**: Returns to contact list after successful update
- **Validation**: Same validation rules as add contact

### About Screen
- **App Info**: Version and description
- **Developer**: Student information (Ama Aseda Annor - ID: 58352026)
- **Branding**: Consistent purple theme

## 🎨 Design System

### Color Scheme
- **Primary**: `Color.fromARGB(255, 223, 106, 247)` (Purple)
- **Success**: Green for positive actions
- **Error**: Red for error states
- **Text**: Material Design defaults

### UI Components
- **AppBar**: Purple theme with white text
- **Cards**: Material cards for contact items
- **Buttons**: Elevated buttons with loading states
- **Forms**: Outlined text fields with validation
- **Navigation**: Bottom navigation with icons

## 🔄 API Integration

### ApiService Class
```dart
class ApiService {
  final String baseUrl = "https://apps.ashesi.edu.gh/contactmgt/actions";
  
  // CRUD Operations
  Future<List<Map<String, dynamic>>> getAllContacts()
  Future<Map<String, dynamic>> getSingleContact(int contid)
  Future<String> addNewContact(String fullname, String phone)
  Future<String> updateContact(int cid, String fullname, String phone)
  Future<bool> deleteContact(int contactId)
}
```

### Error Handling
- Network error handling with try-catch blocks
- User-friendly error messages
- Loading states during API calls
- Graceful failure with retry options

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point and navigation
├── screens/
│   ├── about.dart              # About screen
│   ├── add_contact.dart        # Add contact form
│   ├── contacts_list.dart      # Contact list display
│   └── edit_contact.dart       # Edit contact form
└── services/
    └── api.dart                # API service for HTTP calls
```

## 🔍 Code Features

### Form Validation
```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter a name';
  }
  return null;
}
```

### Phone Number Validation
```dart
validator: (value) {
  if (!RegExp(r'^0\d{9}$').hasMatch(value)) {
    return 'Enter a valid 10-digit phone number';
  }
  return null;
}
```

### Loading States
```dart
child: _isLoading
    ? const CircularProgressIndicator(color: Colors.white)
    : const Text('Add Contact')
```

## 🚀 Usage

1. **Launch the app** - Opens to contact list screen
2. **View Contacts** - See all existing contacts
3. **Add Contact** - Tap "Add" tab, fill form, submit
4. **Edit Contact** - Tap edit icon on any contact
5. **Delete Contact** - Tap delete icon, confirm deletion
6. **Refresh** - Pull down on contact list to refresh

## 🧪 Testing

### Manual Testing Checklist
- [ ] Add new contact with valid data
- [ ] Add contact with invalid phone format
- [ ] Edit existing contact
- [ ] Delete contact with confirmation
- [ ] Pull to refresh contact list
- [ ] Navigate between all tabs
- [ ] Test with empty contact list
- [ ] Test network error scenarios

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  # Add other dependencies as needed

dev_dependencies:
  flutter_test:
    sdk: flutter
```

## 🔮 Future Enhancements

- [ ] Search and filter contacts
- [ ] Contact categories/groups
- [ ] Import/Export contacts
- [ ] Contact photos
- [ ] Backup and sync
- [ ] Dark mode support
- [ ] Offline mode with local storage
- [ ] Contact sharing functionality

## 🐛 Troubleshooting

### Common Issues

**API Connection Problems:**
- Check internet connectivity
- Verify API endpoint availability
- Check network permissions in Android manifest

**Form Validation Issues:**
- Ensure phone numbers start with 0
- Check for empty fields
- Verify 10-digit phone format

**Build Errors:**
```bash
flutter clean
flutter pub get
flutter run
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- Ashesi University for providing the API infrastructure
- Material Design team for UI/UX guidelines

## 📞 Support

For questions or issues:
- Create an issue in this repository
- Contact the developer through Ashesi University channels

---

**📱 Built with Flutter | 💜 Made with care**
