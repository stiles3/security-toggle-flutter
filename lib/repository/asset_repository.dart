import 'package:security_toggle_app/api/asset_api.dart';

abstract class AssetRepository {
  Future<bool> getAssetStatus();
  Future<bool> toggleAsset();
}

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource remoteDataSource;

  AssetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> getAssetStatus() => remoteDataSource.getAssetStatus();

  @override
  Future<bool> toggleAsset() => remoteDataSource.toggleAsset();
}
