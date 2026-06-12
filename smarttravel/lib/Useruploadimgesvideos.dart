import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarttravel/user%20home.dart';

class FileUploadScreen extends StatefulWidget {
  final String travelogueId;

  FileUploadScreen({required this.travelogueId});

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;
  String? _fileType = 'image'; // 'video' or 'image'
  TextEditingController _ytsController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  List<Map<String, dynamic>> fileData = [];

  void _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _uploadFile() async {
    if (_selectedFile == null) {
      // Handle case where no file is selected
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("ip") ?? '';
    String lid = sh.getString("lid") ?? '';

    try {
      String url = "$ip/api/user_upload_file"; // Replace with your actual API endpoint
      FormData formData = FormData.fromMap({
        'yts': _ytsController.text,
        'desc': _descController.text,
        'lid': lid,
        'ftype': _fileType,
        'file': await MultipartFile.fromFile(
          _selectedFile!.path,
          filename: 'file',
        ),
        'travelogue_id': widget.travelogueId,
      });

      Response response = await Dio().post(url, data: formData);

      if (response.data['status'] == 'success') {
        // File uploaded successfully
        print('File uploaded successfully');
        _fetchFiles(); // Fetch files after successful upload
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserViewDetailsApp()));
      } else {
        // Handle failure case
        print('File upload failed');
      }
    } catch (error) {
      // Handle error
      print('Error uploading file: $error');
    }
  }

  Future<void> _fetchFiles() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("ip") ?? '';

    try {
      String url = "$ip/api/user_view_images_videos";
      FormData formData = FormData.fromMap({'travelogue_id': widget.travelogueId});
      Response response = await Dio().post(url, data: formData);

      if (response.data['status'] == 'ok') {
        setState(() {
          fileData = List<Map<String, dynamic>>.from(response.data['data']);
        });

      } else {
        print('Failed to fetch files');
      }
    } catch (error) {
      print('Error fetching files: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFiles(); // Fetch files when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _selectFile,
              icon: Icon(Icons.file_upload),
              label: Text('Select File'),
            ),
            SizedBox(height: 16),
            if (_selectedFile != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected File Details:'),
                  Text('File Path: ${_selectedFile!.path}'),
                ],
              ),
            SizedBox(height: 16),
            DropdownButton<String?>(
              value: _fileType,
              onChanged: (String? value) {
                setState(() {
                  _fileType = value;
                });
              },
              items: ['image', 'video'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ytsController,
              decoration: InputDecoration(labelText: 'Youtube Links'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
