# Bonfire
A Chat Application that allows users to communicate with other users and potentially leave location based messages.


# How to Use: 
- Run pod install to grab relevant packages and build.

Please Login with Email Given. 
email: test1@gmail.com or test2@gmail.com
password: password

Test Users: Dog Dog, Cat Cat. These are the only users available with the given emails respectively. Used to test functionally. 

- Google Login works, however it is not recommended as I only intend to hold test emails for account security reasons. Please use given emails.

## Architecture
The main architecture pattern is MVC. 
However many of the views are generated programmatically due to old hardware having issues running storyboard.

# WARNING: REQUIRES Xcode 13.0, 13.2 and above leads to seg fault
- Currently Realm packge is not in use, so any Xcode version should be fine. 
- Realm Package appears to have a seg fault error with Xcode versions of 13.2 and above, fix has yet to be released so , version 13.0 is recommended.


## Additional Sections
- Firebase was used as a backend to store data.
- CocoaPods was used as a Package Manager.
- SF Symbols provided some icon usage.
- MessageKit gave UI tools for the chat system.
- JGProgressHUD was used to generate loading/ progress bars when waiting on calls to Firebase.

## Tutorials/ References

- Chat Application & Firebase References
https://www.youtube.com/watch?v=6v4fmg9iRSU&t=824s
https://www.raywenderlich.com/22067733-firebase-tutorial-real-time-chat#toc-anchor-010

- Map Messages (NOT Implemented)
https://www.raywenderlich.com/9956648-mapkit-tutorial-overlay-views
- Potentially used to generate "footprints" messages over a map, however lack of preparation and time limited our goal.

## Thoughts/ Future Goals
- Looking back certain aspects certainly took more time than expected especially with time constraints. Although I was not able to implement the "footprint" messages, I have a good idea of how to implement that using the functions for the chat implementation. 
- Future goals would be to definitely finish the map aspect of this app. As well as use the Realm Package, might be useful for storing data so we do not need to call firebase repeatedly. 