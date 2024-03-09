import 'package:codemetech/features/Home/home-repository/home-repository.dart';
import 'package:codemetech/model/leads-model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
StateNotifierProvider<HomeController, bool>((ref) {
  return HomeController(ref: ref,homeRepository: ref.watch(homeRepositoryProvider));
});

class HomeController extends StateNotifier<bool> {

  final HomeRepository _homeRepository;
  final Ref _ref;

  HomeController({required HomeRepository homeRepository, required Ref ref})
      : _homeRepository = homeRepository,
        _ref = ref,
        super(false);


  @override
  build() {
    return false;
  }

  ///getAllLeads
  Future<List<LeadModel>> getAllLeads(String token) {
    return _homeRepository.getAllLeads(token);
  }
}