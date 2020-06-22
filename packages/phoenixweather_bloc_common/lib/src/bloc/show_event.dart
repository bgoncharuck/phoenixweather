part of 'show_bloc.dart';

abstract class ShowEvent extends Equatable {
  const ShowEvent();
}

class ShowItemEvent extends ShowEvent {

  final WeatherModel item;
  ShowItemEvent({@required this.item});

  @override
  List<Object> get props => [item];
  @override
  bool get stringify => true;
} // One Item

class ShowDayEvent extends ShowEvent {
  final innerEvent;
  final CurrentData data;
  final int day;
  final List<WeatherModel> items= [];

  ShowDayEvent({
    @required this.data,
    @required day,
    this.innerEvent= false,
  }) : this.day= 
    // days must be 1-7
  (day > 0 && day <= 7) ? day : 
  (day > 7) ? 7 : 1
  {
      // first two days as hourly
      if (day < 3) {
        int start, end;
        
        if (day == 1) {
          start= 0;
          end= 24;
        }
        else {
          start= 24;
          end= 48;
        }

        for (int hour= start; hour < end; hour++)
          items.add(data.hourly[hour]);
    } 
    // from 3 days - daily
    else  if (day >=  3) {
      items.add(data.daily[day-1].night);
      items.add(data.daily[day-1].morning);
      items.add(data.daily[day-1].day);
      items.add(data.daily[day-1].evening);
    }
  } 

    @override
  List<Object> get props => [items];
  @override
  bool get stringify => true;
} // Day