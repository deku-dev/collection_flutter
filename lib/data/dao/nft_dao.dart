// nft_dao.dart
import 'package:floor/floor.dart';

import '../../domain/entities/nft_entity.dart';

@dao
abstract class NFTDao {
  @Query('SELECT * FROM NFT WHERE id = :nftId')
  Future<NFTEntity?> getNFTById(int nftId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNFT(NFTEntity nft);

  @Query('UPDATE NFT SET ownerId = :newOwnerId WHERE id = :nftId')
  Future<void> transferNFT(int nftId, int newOwnerId);

  @Query('DELETE FROM NFT WHERE id = :nftId')
  Future<void> deleteNFT(int nftId);
}
