import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/domain/entities/tva.dart';

abstract class TVARepository {
  ResultFuture<List<TVA>> getAllTVAs();
  ResultFuture<String?> createOrUpdateTVA(DataMap params);
  ResultFuture<bool> deleteTVA(String id);
}
