import 'package:evento/features/events/home/model/event_model.dart';
import 'package:get/get.dart';

class EventStateManager {
  final RxList<EventModel> _allEvents = RxList<EventModel>();

  // Add or update an event in the list
  void addOrUpdateEvent(EventModel event) {
    int index = _allEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _allEvents[index] = event;
    } else {
      _allEvents.add(event);
    }
    _allEvents.refresh(); // Refresh the list to notify listeners
  }

  // Retrieve an event by its ID
  Rx<EventModel> getEventById(int eventId) {
    return _allEvents.firstWhere((e) => e.id == eventId).obs;
  }

  // Toggle the favorite state of an event
  void toggleFavorite(int eventId) {
    var event = getEventById(eventId).value;
    event.isFollowedByAuthUser = !event.isFollowedByAuthUser;
    addOrUpdateEvent(event);
  }

  // Retrieve all events
  List<EventModel> get allEvents => _allEvents;
}
