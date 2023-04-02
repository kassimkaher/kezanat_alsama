part of 'dua_cubit.dart';

abstract class DuaState extends Equatable {
  final DuaData info;
  const DuaState(this.info);

  @override
  List<Object> get props => [info];
}

class DuaStateInital extends DuaState {
  const DuaStateInital(super.info);
}

class DuaStateLoaded extends DuaState {
  const DuaStateLoaded(super.info);
}

class DuaStateLoading extends DuaState {
  const DuaStateLoading(super.info);
}

class DuaStateFiald extends DuaState {
  const DuaStateFiald(super.info);
}

class DuaData {
  dynamic storage;
  RamadanDuaModel? ramadanDuaModel;
  DuaData({
    this.storage,
  });

  var documentExpanded = false;

  ZyaratMunajatModel? zyaratData;
}
