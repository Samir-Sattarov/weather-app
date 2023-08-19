class StringHelper {
  static String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Январь';
      case 2:
        return 'Февраль';
      case 3:
        return 'Март';
      case 4:
        return 'Апрель';
      case 5:
        return 'Май';
      case 6:
        return 'Июнь';
      case 7:
        return 'Июль';
      case 8:
        return 'Август';
      case 9:
        return 'Сентябрь';
      case 10:
        return 'Октябрь';
      case 11:
        return 'Ноябрь';
      case 12:
        return 'Декабрь';
      default:
        return '';
    }
  }

 static String getHumidityDescription(int humidity) {
    if (humidity <= 30) {
      return "Сухой";
    } else if (humidity > 30 && humidity <= 70) {
      return "Умеренная влажность";
    } else if (humidity > 70 && humidity < 100) {
      return "Влажный воздух";
    } else if (humidity == 100) {
      return "Высокая влажность";
    } else {
      return "Недостоверное значение";
    }
  }
  //
  // static String formatDateForWeatherByHoursItem(DateTime dt) {
  //   return
  // }

  static String getWindDirection(double degrees) {
    if ((degrees >= 0 && degrees <= 22.5) || (degrees > 337.5 && degrees <= 360)) {
      return "Северный";
    } else if (degrees > 22.5 && degrees <= 67.5) {
      return "Северо-восточный";
    } else if (degrees > 67.5 && degrees <= 112.5) {
      return "Восточный";
    } else if (degrees > 112.5 && degrees <= 157.5) {
      return "Юго-восточный";
    } else if (degrees > 157.5 && degrees <= 202.5) {
      return "Южный";
    } else if (degrees > 202.5 && degrees <= 247.5) {
      return "Юго-западный";
    } else if (degrees > 247.5 && degrees <= 292.5) {
      return "Западный";
    } else if (degrees > 292.5 && degrees <= 337.5) {
      return "Северо-западный";
    } else {
      return "Недостоверное направление";
    }
  }



}