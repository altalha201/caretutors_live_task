import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/src/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String _imageUrl = "", _selectedDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image View Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: 400,
              child: Visibility(
                visible: !_isLoading,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: Visibility(
                  visible: _imageUrl.isNotEmpty,
                  replacement: const Center(
                    child: Text("No Image"),
                  ),
                  child: Image.network(
                    _imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_selectedDate),
                TextButton(
                  onPressed: _getDate,
                  child: const Text("Pick Date"),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: _getImageData, child: const Text("Get Image"))
          ],
        ),
      ),
    );
  }

  Future<void> _getDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final dateFormat = DateFormat("yyyy-MM-dd");
      _selectedDate = dateFormat.format(pickedDate);
      setState(() {

      });
    }
  }

  Future<void> _getImageData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await ApiServices.getImageData(_selectedDate);
      if (data.url != null && data.mediaType == "image") {
        _imageUrl = data.url ?? "";
      }
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Image get Success")));
      }
    } catch (e) {
      log(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something Went Wrong")));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
