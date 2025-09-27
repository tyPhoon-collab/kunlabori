import 'package:kunlabori/application/document_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_case_provider.g.dart';

@Riverpod(keepAlive: true)
DocumentUseCase documentUseCase(Ref ref) {
  return DocumentUseCase(ref);
}
