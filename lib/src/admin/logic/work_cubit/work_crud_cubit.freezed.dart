// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_crud_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WorkCrudState {
  DataStatus get dataStatus => throw _privateConstructorUsedError;
  DailyWorkData? get dailyWorkData => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus dataStatus, DailyWorkData? dailyWorkData)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus dataStatus, DailyWorkData? dailyWorkData)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus dataStatus, DailyWorkData? dailyWorkData)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkCrudStateCopyWith<WorkCrudState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkCrudStateCopyWith<$Res> {
  factory $WorkCrudStateCopyWith(
          WorkCrudState value, $Res Function(WorkCrudState) then) =
      _$WorkCrudStateCopyWithImpl<$Res, WorkCrudState>;
  @useResult
  $Res call({DataStatus dataStatus, DailyWorkData? dailyWorkData});
}

/// @nodoc
class _$WorkCrudStateCopyWithImpl<$Res, $Val extends WorkCrudState>
    implements $WorkCrudStateCopyWith<$Res> {
  _$WorkCrudStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = null,
    Object? dailyWorkData = freezed,
  }) {
    return _then(_value.copyWith(
      dataStatus: null == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      dailyWorkData: freezed == dailyWorkData
          ? _value.dailyWorkData
          : dailyWorkData // ignore: cast_nullable_to_non_nullable
              as DailyWorkData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $WorkCrudStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DataStatus dataStatus, DailyWorkData? dailyWorkData});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$WorkCrudStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = null,
    Object? dailyWorkData = freezed,
  }) {
    return _then(_$InitialImpl(
      dataStatus: null == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      dailyWorkData: freezed == dailyWorkData
          ? _value.dailyWorkData
          : dailyWorkData // ignore: cast_nullable_to_non_nullable
              as DailyWorkData?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({this.dataStatus = DataStatus.ideal, this.dailyWorkData});

  @override
  @JsonKey()
  final DataStatus dataStatus;
  @override
  final DailyWorkData? dailyWorkData;

  @override
  String toString() {
    return 'WorkCrudState.initial(dataStatus: $dataStatus, dailyWorkData: $dailyWorkData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.dataStatus, dataStatus) ||
                other.dataStatus == dataStatus) &&
            (identical(other.dailyWorkData, dailyWorkData) ||
                other.dailyWorkData == dailyWorkData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dataStatus, dailyWorkData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus dataStatus, DailyWorkData? dailyWorkData)
        initial,
  }) {
    return initial(dataStatus, dailyWorkData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus dataStatus, DailyWorkData? dailyWorkData)?
        initial,
  }) {
    return initial?.call(dataStatus, dailyWorkData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus dataStatus, DailyWorkData? dailyWorkData)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(dataStatus, dailyWorkData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements WorkCrudState {
  const factory _Initial(
      {final DataStatus dataStatus,
      final DailyWorkData? dailyWorkData}) = _$InitialImpl;

  @override
  DataStatus get dataStatus;
  @override
  DailyWorkData? get dailyWorkData;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
