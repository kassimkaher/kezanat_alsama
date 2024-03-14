// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart' as _i6;
import 'package:ramadan/src/main_app/quran/cubit/quran_search_cubit.dart'
    as _i4;
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart'
    as _i3;
import 'package:ramadan/src/main_app/quran/quran_sound/quran_sound_cubit.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.QuranJuzuCubit>(_i3.QuranJuzuCubit());
    gh.singleton<_i4.QuranSearchCubit>(_i4.QuranSearchCubit());
    gh.factory<_i5.QuranSoundCubit>(() => _i5.QuranSoundCubit());
    gh.singleton<_i6.WorkCrudCubit>(_i6.WorkCrudCubit());
    return this;
  }
}
