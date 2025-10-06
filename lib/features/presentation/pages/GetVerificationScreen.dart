import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/user_bloc.dart';
import '../../presentation/bloc/user_events.dart';
import '../../presentation/bloc/user_states.dart';

class GetVerificationPage extends StatefulWidget {
  const GetVerificationPage({super.key});

  @override
  State<GetVerificationPage> createState() => _GetVerificationPageState();
}

class _GetVerificationPageState extends State<GetVerificationPage> {
  File? idProof;
  final noteController = TextEditingController();
  String responseMsg = "";

  void submitVerification() {
    if (idProof == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload ID proof")),
      );
      return;
    }

    context.read<UserBloc>().add(
      RequestVerificationEvent(idProof: idProof!, note: noteController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is VerificationSubmittedState) {
          setState(() => responseMsg = "Verification request submitted");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verification request submitted")),
          );
        } else if (state is UserError) {
          setState(() => responseMsg = state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Get Verified", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.black)),
        centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage("assets/images/verificationimage.png")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    final source = await showDialog<ImageSource>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Choose Image Source"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, ImageSource.camera),
                            child: const Text("Camera"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, ImageSource.gallery),
                            child: const Text("Gallery"),
                          ),
                        ],
                      ),
                    );
                    if (source != null) {
                      final picked = await ImagePicker().pickImage(source: source);
                      if (picked != null) {
                        final file = File(picked.path);
                        final fileSize = await file.length();
                        if (fileSize > 5 * 1024 * 1024) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("File too large. Max 5MB allowed")),
                          );
                          return;
                        }
                        setState(() => idProof = file);
                      }
                    }
                  },
                  child: Text(idProof == null ? "Upload ID Proof" : "Change ID Proof", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                ),
                if (idProof != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Image.file(idProof!, height: 200),
                  ),

                const SizedBox(height: 16),
                TextField(
                  controller: noteController,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "Note (optional)",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final isLoading = state is VerificationSubmittingState;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        elevation: 20,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: isLoading ? null : submitVerification,
                      child: isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text("Submit Request", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(responseMsg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
