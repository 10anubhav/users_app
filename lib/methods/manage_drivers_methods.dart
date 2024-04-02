import 'package:users_app/models/online_nearby_drivers.dart';

class ManageDriverMethods
{
  static List<OnlineNearbyDrivers> nearbyOnlineDriversList = [];
  static void removeDriverFromList(String driverID )
  {
    int index =nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == driverID);

    if(nearbyOnlineDriversList.length>0)
      {
        nearbyOnlineDriversList.removeAt(index);
      }
  }
  static void updateOnlineNearbyDriverLocation(OnlineNearbyDrivers nearbyOnlineDriverInformation)
  {
    int index =nearbyOnlineDriversList.indexWhere((driver) => driver.uidDriver == nearbyOnlineDriverInformation.uidDriver);
    nearbyOnlineDriversList[index].latDriver = nearbyOnlineDriverInformation.latDriver;
    nearbyOnlineDriversList[index].lngDriver = nearbyOnlineDriverInformation.lngDriver;

  }
}