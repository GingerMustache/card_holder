import 'package:card_holder/common/di_container/modules/di_module_services.dart';
import 'package:card_holder/domain/repositories/local/card_repository.dart';
import 'package:card_holder/domain/repositories/local/file_pick_repository.dart';
import 'package:card_holder/domain/repositories/local/shared_repository.dart';

abstract interface class DiModuleRepository {
  CardRepository get card;
  ShareRepository get share;
  FilePickRepository get filePick;
}

final class DiModuleRepositoryImpl implements DiModuleRepository {
  DiModuleRepositoryImpl(this._services);

  final DiModuleServices _services;

  @override
  late final ShareRepository share = ShareRepositoryImpl(
    shareService: _services.share,
  );
  @override
  late final FilePickRepository filePick = FilePickRepositoryImpl(
    filePickService: _services.filePick,
  );
  @override
  late final CardRepository card = CardRepositoryImpl(
    localCardService: _services.card,
    netShareRepository: share,
  );
}
