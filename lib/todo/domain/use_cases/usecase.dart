import 'package:fpdart/fpdart.dart';

abstract class UseCase<SuccessType, Param> {
  Either<Exception, SuccessType> call(Param param);
}

class NoParams{}
