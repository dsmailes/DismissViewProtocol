# ViewDismissProvider
A SwiftUI protocol and view modifier to dismiss views from view models

Usage:
 - conform your view model to DismissViewProtocol
 - add an instance of DismissViewComponent() to your view model
 - modify your view with .dismissable(<YourViewModel>)
 - set DismissViewComponent().shouldDismissView to true when you want to dismiss your view
