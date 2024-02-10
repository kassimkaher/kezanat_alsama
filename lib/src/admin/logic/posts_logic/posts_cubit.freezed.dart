// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostsCRUDState {
  DataStatus get datastatus => throw _privateConstructorUsedError;
  DailyPostsModel? get dailyPostsModel => throw _privateConstructorUsedError;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get refrenses =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus datastatus,
            DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus datastatus, DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus datastatus, DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)?
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
  $PostsCRUDStateCopyWith<PostsCRUDState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsCRUDStateCopyWith<$Res> {
  factory $PostsCRUDStateCopyWith(
          PostsCRUDState value, $Res Function(PostsCRUDState) then) =
      _$PostsCRUDStateCopyWithImpl<$Res, PostsCRUDState>;
  @useResult
  $Res call(
      {DataStatus datastatus,
      DailyPostsModel? dailyPostsModel,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses});
}

/// @nodoc
class _$PostsCRUDStateCopyWithImpl<$Res, $Val extends PostsCRUDState>
    implements $PostsCRUDStateCopyWith<$Res> {
  _$PostsCRUDStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? dailyPostsModel = freezed,
    Object? refrenses = freezed,
  }) {
    return _then(_value.copyWith(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      dailyPostsModel: freezed == dailyPostsModel
          ? _value.dailyPostsModel
          : dailyPostsModel // ignore: cast_nullable_to_non_nullable
              as DailyPostsModel?,
      refrenses: freezed == refrenses
          ? _value.refrenses
          : refrenses // ignore: cast_nullable_to_non_nullable
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $PostsCRUDStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DataStatus datastatus,
      DailyPostsModel? dailyPostsModel,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PostsCRUDStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? dailyPostsModel = freezed,
    Object? refrenses = freezed,
  }) {
    return _then(_$InitialImpl(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      dailyPostsModel: freezed == dailyPostsModel
          ? _value.dailyPostsModel
          : dailyPostsModel // ignore: cast_nullable_to_non_nullable
              as DailyPostsModel?,
      refrenses: freezed == refrenses
          ? _value._refrenses
          : refrenses // ignore: cast_nullable_to_non_nullable
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.datastatus = DataStatus.ideal,
      this.dailyPostsModel,
      final List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses})
      : _refrenses = refrenses;

  @override
  @JsonKey()
  final DataStatus datastatus;
  @override
  final DailyPostsModel? dailyPostsModel;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? _refrenses;
  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get refrenses {
    final value = _refrenses;
    if (value == null) return null;
    if (_refrenses is EqualUnmodifiableListView) return _refrenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PostsCRUDState.initial(datastatus: $datastatus, dailyPostsModel: $dailyPostsModel, refrenses: $refrenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.datastatus, datastatus) ||
                other.datastatus == datastatus) &&
            (identical(other.dailyPostsModel, dailyPostsModel) ||
                other.dailyPostsModel == dailyPostsModel) &&
            const DeepCollectionEquality()
                .equals(other._refrenses, _refrenses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, datastatus, dailyPostsModel,
      const DeepCollectionEquality().hash(_refrenses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus datastatus,
            DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)
        initial,
  }) {
    return initial(datastatus, dailyPostsModel, refrenses);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus datastatus, DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)?
        initial,
  }) {
    return initial?.call(datastatus, dailyPostsModel, refrenses);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus datastatus, DailyPostsModel? dailyPostsModel,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(datastatus, dailyPostsModel, refrenses);
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

abstract class _Initial implements PostsCRUDState {
  const factory _Initial(
          {final DataStatus datastatus,
          final DailyPostsModel? dailyPostsModel,
          final List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) =
      _$InitialImpl;

  @override
  DataStatus get datastatus;
  @override
  DailyPostsModel? get dailyPostsModel;
  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get refrenses;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
