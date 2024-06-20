import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/database.dart';
import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(context.read<AppDatabase>()),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login successful!')),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    context.read<LoginCubit>().login(username, password);
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    final email = _emailController.text;
                    context.read<LoginCubit>().register(username, password, email);
                  },
                  child: Text('Register'),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
