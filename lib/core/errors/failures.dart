import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}
class ServerFailure extends Failure{
  const ServerFailure (String massage):super(message: massage);
}
class ConnectionFailure extends Failure{
  const ConnectionFailure (String massage):super(message: massage);
}
class DateBaseFailure extends Failure{
  const DateBaseFailure (String massage):super(message: massage);
}