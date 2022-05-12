# Bonfire
A generalized chat app that allows users to message other users and leave location based messages for everyone to read. The idea behind this is that users will be able to leave location based messages at any area with a limited number of text, similar to a recent popular game. 

# How to Use: 
- Run pod install to grab relevant packages and build.

Please Login with Email Given. 

Google Login works however it is not recommended as I only intend to hold test emails for accounts for security reasons. 

# WARNING: REQUIRES Xcode 13.0, 13.2 and above leads to seg fault
- Realm Package appears to have a seg fault error with Xcode versions 13.2 and above, fix has yet to be merged so, version 13.0 is used.

## Architecture
The main architecture pattern is mvc. 
However most of the views are generated programmatically. 

## Additional Sections
Firebase was used as a backend to store data.
CocoaPods was used as a Package Manager
SF Symbols was used for icon images.
MessageKit was used to create the UI for the chat system.
JGProgressHUD was used to genereate load progress bars when waiting for data. 