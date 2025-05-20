import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/asset/asset_bloc.dart';
import '../bloc/asset/asset_event.dart';
import '../bloc/asset/asset_state.dart';

class AssetToggleWidget extends StatelessWidget {
  const AssetToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Asset is ${state.isSecured ? 'SECURED 🔒' : 'UNSECURED 🔓'}',
              style: TextStyle(
                fontSize: 24,
                color: state.isSecured ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            switch (state) {
              AssetLoading() => const CircularProgressIndicator(),
              _ => Switch(
                  value: state.isSecured,
                  onChanged: (_) {
                    print('This is a basic log message');
                    context.read<AssetBloc>().add(ToggleAssetEvent());
                  }),
            },
          ],
        );
      },
    );
  }
}
