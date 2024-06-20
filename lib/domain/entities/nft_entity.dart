// nft_entity.dart
import 'package:floor/floor.dart';

@Entity(tableName: 'NFT')
class NFTEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String tokenId;
  final String tokenName;
  final String tokenDescription;
  final String imageUrl;
  final int ownerId; // ID власника NFT (зв'язок з сутністю UserEntity)

  NFTEntity({
    required this.id,
    required this.tokenId,
    required this.tokenName,
    required this.tokenDescription,
    required this.imageUrl,
    required this.ownerId,
  });
}
