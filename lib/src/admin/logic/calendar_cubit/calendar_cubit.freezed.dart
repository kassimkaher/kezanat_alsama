// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalendarState {
  DataStatus<dynamic> get datastatus => throw _privateConstructorUsedError;
  CalendarModel? get calendarModel => throw _privateConstructorUsedError;
  CalendarModel? get today => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)?
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
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) then) =
      _$CalendarStateCopyWithImpl<$Res, CalendarState>;
  @useResult
  $Res call(
      {DataStatus<dynamic> datastatus,
      CalendarModel? calendarModel,
      CalendarModel? today});
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res, $Val extends CalendarState>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? calendarModel = freezed,
    Object? today = freezed,
  }) {
    return _then(_value.copyWith(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>,
      calendarModel: freezed == calendarModel
          ? _value.calendarModel
          : calendarModel // ignore: cast_nullable_to_non_nullable
              as CalendarModel?,
      today: freezed == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as CalendarModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DataStatus<dynamic> datastatus,
      CalendarModel? calendarModel,
      CalendarModel? today});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? calendarModel = freezed,
    Object? today = freezed,
  }) {
    return _then(_$InitialImpl(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>,
      calendarModel: freezed == calendarModel
          ? _value.calendarModel
          : calendarModel // ignore: cast_nullable_to_non_nullable
              as CalendarModel?,
      today: freezed == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as CalendarModel?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.datastatus, this.calendarModel, this.today});

  @override
  final DataStatus<dynamic> datastatus;
  @override
  final CalendarModel? calendarModel;
  @override
  final CalendarModel? today;

  @override
  String toString() {
    return 'CalendarState.initial(datastatus: $datastatus, calendarModel: $calendarModel, today: $today)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.datastatus, datastatus) ||
                other.datastatus == datastatus) &&
            (identical(other.calendarModel, calendarModel) ||
                other.calendarModel == calendarModel) &&
            (identical(other.today, today) || other.today == today));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, datastatus, calendarModel, today);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)
        initial,
  }) {
    return initial(datastatus, calendarModel, today);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)?
        initial,
  }) {
    return initial?.call(datastatus, calendarModel, today);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus<dynamic> datastatus,
            CalendarModel? calendarModel, CalendarModel? today)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(datastatus, calendarModel, today);
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

abstract class _Initial implements CalendarState {
  const factory _Initial(
      {required final DataStatus<dynamic> datastatus,
      final CalendarModel? calendarModel,
      final CalendarModel? today}) = _$InitialImpl;

  @override
  DataStatus<dynamic> get datastatus;
  @override
  CalendarModel? get calendarModel;
  @override
  CalendarModel? get today;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
