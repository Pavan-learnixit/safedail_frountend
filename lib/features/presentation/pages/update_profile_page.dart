import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/datasources/api_service.dart';
import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/domain/usecases/update_profile_usecase.dart';
import '../../presentation/bloc/update_profile_bloc.dart';
import '../../presentation/bloc/update_profile_event.dart';
import '../../presentation/bloc/update_profile_state.dart';
import '../../auth/domain/entities/profile.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String responseMsg = "";

  void submitUpdate() {
    final profile = Profile(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );

    context.read<UpdateProfileBloc>().add(SubmitProfileUpdate(profile));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProfileBloc>(
      create: (_) {
        final apiService = ApiService();
        final authRepository = AuthRepositoryImpl(apiService);
        final updateProfileUseCase = UpdateProfileUseCase(authRepository);
        return UpdateProfileBloc(updateProfileUseCase);
      },
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            setState(() => responseMsg = state.message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is UpdateProfileFailure) {
            setState(() => responseMsg = state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Update Profile")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
                const SizedBox(height: 20),
                BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                  builder: (context, state) {
                    final isLoading = state is UpdateProfileLoading;
                    return ElevatedButton(
                      onPressed: isLoading ? null : submitUpdate,
                      child: isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Update"),
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
