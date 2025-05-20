import 'package:equatable/equatable.dart';

sealed class AssetState extends Equatable {
  final bool isSecured;
  final DateTime? lastUpdated;

  const AssetState({this.isSecured = false, this.lastUpdated});

  @override
  List<Object?> get props => [isSecured, lastUpdated];
}

class AssetInitial extends AssetState {
  const AssetInitial() : super(isSecured: false);
}

class AssetLoading extends AssetState {
  final bool currentSecuredState;
  const AssetLoading(this.currentSecuredState)
      : super(isSecured: currentSecuredState);
}

class AssetLoaded extends AssetState {
  final String? successMessage; // Add this

  const AssetLoaded({
    required bool isSecured,
    DateTime? lastUpdated,
    this.successMessage, // Add this
  }) : super(isSecured: isSecured, lastUpdated: lastUpdated);
}

class AssetError extends AssetState {
  final String message;
  final bool previousState;

  const AssetError({
    required this.message,
    required this.previousState,
  }) : super(isSecured: previousState);
}
