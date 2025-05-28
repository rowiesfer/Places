# `Places`

Simple app to test deeplinking into the Wikipedia app. Selecting a place in the app will deeplink into Wikipedia and show the article for that place in the Places tab.

## Requirements  
Xcode 16.3+  
Swift 6+

## Running it

### Places app  
To run the app, just open this project using Xcode 16.3+ and hit Run.

### Wikipedia app  
In order to successfully navigate to a place in the Wikipedia app, you need to check out my fork of the Wikipedia app and use the branch called `deeplink-to-place`.  
Here is a [link to it](https://github.com/rowiesfer/wikipedia-ios/tree/deeplink-to-place).  
To run the app, just open the project and hit Run.

## Using it  
Once you have the Wikipedia app installed, you can run the Places app and use it. Tap on a list item to try it.

These are the features implemented at the moment:  
- [Place list](https://github.com/rowiesfer/Places/blob/main/Features/PlaceList/PlaceList.docc/PlaceList.md#list)  
- [Custom place](https://github.com/rowiesfer/Places/blob/main/Features/PlaceList/PlaceList.docc/PlaceList.md#custom-place)

## Architecture

### Modularization
Modularization is very important in mobile apps to control dependencies spread all over the project, causing side effects when modifying small parts of it, making dependencies difficult to replace or update, and making compile times longer, among other problems.  
On the other hand, having too many modules can lead to higher complexity of the dependency tree and longer app startup time.  
Choosing the right approach depends a lot on the project.

In this small app I want to showcase how I envision modularization, dividing the app into 2 types of modules:

- **Feature modules (vertical modules)**: These contain all the logic needed to present a meaningful user flow,or feature. I call these vertical modules because they work "end to end", without relying on other features.  
  *Example: `PlaceList` module.*

- **Infrastructure modules (horizontal modules)**: These contain logic that can be abstracted away from multiple feature modules and referenced from them.  
  For example: networking, security, persistent storage, etc.  
  *Example: `PlacesAPI` module.*

Because this is an example app, you can only see one of each type, but the idea can be generalized.

![Modularization example](https://github.com/rowiesfer/Places/blob/main/Places.docc/Resources/modularization_example.png)

### Architecture of feature modules
The architecture I've chosen for the feature modules is a falvour of MVVVM+Coordinator with repositories.

#### Model-View-ViewModel
Used to extract most of the logic out of the views, which improves testability. Personally, I think it scales quite well and, if implemented correctly, hits the sweet spot between scalability and complexity.

Since I'm using SwiftUI, the view model is observable and exposes a single property called viewState to the view. Setting the whole view state at once helps avoid side effects of having multiple values set at different times, leading to exponential view configurations that can independently change.
Touches and other events are sent back to the view model for processing. This will update the view accordingly or communicate to the coordinator if another view needs to be presented.

#### Coordinator
Coordinators are useful to encapsulate the logic related to the presentation of views and navigation between them.
Coordinators allow for better reusability of views, since they can be presented from anywhere in the app. It also goes hand in hand with the idea of feature modules, normally having a parent coordinator for a given feature, which could have child coordinators if the flow of the feature is complex.
The app can have a base coordinator to handle which feature is presented first, handle deep links, etc.

#### Repository
I also introduced the use of repositories as an abstraction of the data source. This allows the feature logic to be independent of the data source; adding caching, persistence, or removing one of those is limited to changes to the repository.

#### Picture of a similar setup
![MVVMC example](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*d1DXDtaoZVm8J-exVOkSOw.png)
[image source](https://medium.com/sudo-by-icalia-labs/ios-architecture-mvvm-c-introduction-1-6-815204248518)

### Tests
I have implemented unit tests for the logic in the view model and other classes that have important logic.
The unit tests don't depend on any target; each file needed for the test is added to the test target to ensure we can run the tests without building the whole project.
The unit tests rely on stubs and mocks that I made manually, but for a real project, a proper mocking framework should be used to speed up testing and have less code to maintain.
The coverage of unit tests depends on the project and the team. These tests are there mostly to showcase the test strategy.

The basic UI tests I've implemented are checking transitions between screens. This is useful to detect crashes or dead ends in user flows very early in the CI/CD pipeline.
They can also be used to implement snapshot testing.

## Still to be implemented

Things that I would like to implement later.

### Swift UI based Coordinator/Routing
I've tried to implement navigation using [Navigation Stack](https://developer.apple.com/documentation/swiftui/navigationstack) but I've failed to achieve a clean, reusable and decoupled approach. Hence, I've switched back to having coordinators that wrap SwiftUI views in `UIHostingController`.
I'll keep doing some research to see how navigation can be implemented better with the latest tools.

### Dependency injection framework
I've chosen not to use a dependency injection framework due to the small size of the assignment, and also to showcase a bit that dependency injection can be done manually.
In a real project I would definitely use a framework like `Swinject`, `swift-dependencies`, etc.

### UI testing improvements
The current UI tests are hitting the network, yikes. That should be avoided in real projects since makes UI tests unreliable and slow.

### Swift packages for features
I've seen there are some theoretical advantages of using swift packages for feature modules, like better handling of localization files, or static linking of dependencies. 
Some also say previews don't work that well when building swift ui views in swift packages.
For now I've decided to stick to the good old Xcode dynamic frameworks, but these are linked at startup time, possibly causing long startup times in big apps. So, swift packages might be better.
