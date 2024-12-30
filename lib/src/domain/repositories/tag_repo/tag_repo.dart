import 'package:piece_autos/core/utils/typedef.dart';

import '../../entities/tag.dart';

abstract class TagRepository {
  ResultFuture<List<Tag>> getAllTags(DataMap? params); // For GET
  ResultFuture<String?> createOrUpdateTag(DataMap params); // For POST
  ResultFuture<bool> deleteTag(String id); // For DELETE
}
