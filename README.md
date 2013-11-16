# WordsWithoutFriends Read Me #

This project is the demo code from the CocoaConf session 'Giving Your Table Views an iOS 7 Makeover'.

The sample app 'Words Without Friends' is a basic master-detail app.

The tag 'Start' represents the app before any iOS 7-specific changes are made.

Each commit makes a particular change.

The major changes are:

* Adding Dynamic Type support
* Updating row height when user changes Dynamic Type size
* Updating selection color of table cell labels to not be white
* Adding an animate-alongside animation to the standard interactive transition
* Adding a custom selected background view to the table view cell

To test the Dynamic Type support, leave the app and go to Settings > General > Text Size and adjust the text size to see how the table view changes.

To test the animate-alongside animation, tap a word in the table view to drill into the detail page.  Then swipe from the left edge, to interactively navigate back to the table view.