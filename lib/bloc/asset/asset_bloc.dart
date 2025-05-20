import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../core/execptions.dart';
import '../../repository/asset_repository.dart';
import 'asset_event.dart';
import 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository repository;

  AssetBloc({required this.repository}) : super(const AssetInitial()) {
    on<LoadAssetEvent>(_onLoadAsset);
    on<ToggleAssetEvent>(_onToggleAsset);
  }

  Future<void> _onLoadAsset(
    LoadAssetEvent event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetLoading(state.isSecured));

    try {
      final isSecured = await repository.getAssetStatus();
      emit(AssetLoaded(isSecured: isSecured));
    } catch (e) {
      emit(AssetError(
        message: e.toString(),
        previousState: state.isSecured,
      ));
    }
  }

  Future<void> _onToggleAsset(
    ToggleAssetEvent event,
    Emitter<AssetState> emit,
  ) async {
    emit(AssetLoading(state.isSecured));

    try {
      final isSecured = await repository.toggleAsset();
      emit(AssetLoaded(
        isSecured: isSecured,
        successMessage: isSecured
            ? "Asset secured successfully!"
            : "Asset unsecured!", // Add this
      ));
    } catch (e) {
      final errorMessage = _getUserFriendlyErrorMessage(e);
      emit(AssetError(
        message: errorMessage,
        previousState: state.isSecured,
      ));
    }
  }

  String _getUserFriendlyErrorMessage(dynamic error) {
    if (error is NetworkException) {
      return "No internet connection. Please check your network.";
    } else if (error is TimeoutException) {
      return "Request timed out. Please try again.";
    } else if (error is UnauthorizedException) {
      return "Session expired. Please log in again.";
    } else {
      return "Failed to update asset security. Please try again."; // Fallback
    }
  }
}
