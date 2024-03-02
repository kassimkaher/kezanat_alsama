// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasbeeh_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasbeehState {
  TasbeehModel? get tasbeehModel => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  int get repetitionNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)?
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
  $TasbeehStateCopyWith<TasbeehState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasbeehStateCopyWith<$Res> {
  factory $TasbeehStateCopyWith(
          TasbeehState value, $Res Function(TasbeehState) then) =
      _$TasbeehStateCopyWithImpl<$Res, TasbeehState>;
  @useResult
  $Res call(
      {TasbeehModel? tasbeehModel, int count, int index, int repetitionNumber});
}

/// @nodoc
class _$TasbeehStateCopyWithImpl<$Res, $Val extends TasbeehState>
    implements $TasbeehStateCopyWith<$Res> {
  _$TasbeehStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasbeehModel = freezed,
    Object? count = null,
    Object? index = null,
    Object? repetitionNumber = null,
  }) {
    return _then(_value.copyWith(
      tasbeehModel: freezed == tasbeehModel
          ? _value.tasbeehModel
          : tasbeehModel // ignore: cast_nullable_to_non_nullable
              as TasbeehModel?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      repetitionNumber: null == repetitionNumber
          ? _value.repetitionNumber
          : repetitionNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $TasbeehStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TasbeehModel? tasbeehModel, int count, int index, int repetitionNumber});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TasbeehStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasbeehModel = freezed,
    Object? count = null,
    Object? index = null,
    Object? repetitionNumber = null,
  }) {
    return _then(_$InitialImpl(
      tasbeehModel: freezed == tasbeehModel
          ? _value.tasbeehModel
          : tasbeehModel // ignore: cast_nullable_to_non_nullable
              as TasbeehModel?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      repetitionNumber: null == repetitionNumber
          ? _value.repetitionNumber
          : repetitionNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.tasbeehModel,
      this.count = 0,
      this.index = 0,
      this.repetitionNumber = 1});

  @override
  final TasbeehModel? tasbeehModel;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final int repetitionNumber;

  @override
  String toString() {
    return 'TasbeehState.initial(tasbeehModel: $tasbeehModel, count: $count, index: $index, repetitionNumber: $repetitionNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.tasbeehModel, tasbeehModel) ||
                other.tasbeehModel == tasbeehModel) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.repetitionNumber, repetitionNumber) ||
                other.repetitionNumber == repetitionNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tasbeehModel, count, index, repetitionNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)
        initial,
  }) {
    return initial(tasbeehModel, count, index, repetitionNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)?
        initial,
  }) {
    return initial?.call(tasbeehModel, count, index, repetitionNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TasbeehModel? tasbeehModel, int count, int index,
            int repetitionNumber)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(tasbeehModel, count, index, repetitionNumber);
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

abstract class _Initial implements TasbeehState {
  const factory _Initial(
      {final TasbeehModel? tasbeehModel,
      final int count,
      final int index,
      final int repetitionNumber}) = _$InitialImpl;

  @override
  TasbeehModel? get tasbeehModel;
  @override
  int get count;
  @override
  int get index;
  @override
  int get repetitionNumber;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
