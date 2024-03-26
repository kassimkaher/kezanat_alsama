part of 'document_cubit.dart';

@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState.initial(
      {required DataStatus dataStatus,
      WorksDocumentModel? zyaratData,
      List<DuaEntity>? casheZyarat,
      List<DuaEntity>? casheMunajat,
      List<DuaEntity>? casheDua,
      @Default(WorkType.zyara) WorkType workType}) = _Initial;
}
