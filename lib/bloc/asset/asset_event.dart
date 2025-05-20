import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class LoadAssetEvent extends AssetEvent {}

class ToggleAssetEvent extends AssetEvent {}
