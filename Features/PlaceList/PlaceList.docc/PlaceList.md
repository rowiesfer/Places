# ``PlaceList``

Feature module that is in charge of showing a list of places and a custom place screen.

## List
A list of places fetched from GitHub that shows: name, longitude, and latitude of the place. You can tap on a place to navigate to the Wikipedia app and search for the specific place in the Places tab.
From here you can also navigate to the custom place screen by tapping the button "try your own place".

## Custom place
A simple screen to input a custom name, latitude, and longitude.
It allows deeplinking to the Wikipedia app via the button "open in Wikipedia".

### Architecture
This feature module is a "vertical" module; it does not depend on the main app and it should not depend on other feature modules that could be developed in the future.
It uses an MVVM+Coordinator architecture with SwiftUI that allows for decoupling of the presentation and any other logic, like fetching values, formatting them, or navigating to other views.

This module has its own tests and localizations as well.
It does depend on "horizontal" modules that could be shared by multiple feature modules, like PlacesAPI.
