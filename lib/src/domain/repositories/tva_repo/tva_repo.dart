import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/tva_model.dart';
import 'package:piece_autos/src/domain/entities/tva.dart';

abstract class TVARepository {
  ResultFuture<List<TVA>> getAllTVAs();
  ResultFuture<TvaModel?> createOrUpdateTVA(DataMap params);
  ResultFuture<bool> deleteTVA(String id);
}
