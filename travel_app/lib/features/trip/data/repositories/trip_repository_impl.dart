import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/trip_model.dart';

import '../datasources/trip_local_datasources.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTrips(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final tripModels = localDataSource.getTrips();
      return Right(tripModels);
    } catch (err) {
      return Left(GetTripError(err.toString()));
    }
  }
}
