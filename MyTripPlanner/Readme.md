#  Capstone Requirements

App Functionality: App was used to get places of interest using a natural language search using MapKit. The app has two Tabs: Itinerary List and MapView. The MapView is currently hardcoded to Cupertino, California but was suppose to change based off the user's city input. The Map has the option to look around view, open apple maps with the selected place, get directions and also add to the Itinerary list(not completed yet).

1. Used Xcode 15.3 and minimum deployment is iOS 17.4
2. App has readME file. 
3. The app has a suitable launch screen. It has an animated globe and then an SF symbol airplane moving over text as the onboarding screen.
4. The app has a couple of features incomplete, GeoLocation based off city entry and also adding searched items into the Itinerary List.
5. The app has List in ItineraryListView
6. It has city, country, start date and stop date. Detailed view has the same info with a larger picture displayed.
7. Tapping the list row shows a detailed view where you can navigate back to the main page.
8. The app uses URLSession to download the cities photo from pexels API - used in DestinationDetailView.
9. The app shows "Loading..." when the image has not been loaded. 
10. Using Async Image to download the image to keep the UI responsive during the download.
11. The app is using swiftData and @Model macro is Observable.
11. Initial view has the statement: "No destinations added yet"
12. No blank screens.
13. View components have separate views.
14. No crashes or errors.
15. SwiftLint: going to install it.

