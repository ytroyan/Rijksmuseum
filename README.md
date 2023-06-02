
# Programming assessment - iOS
As part of the hiring process, we would like to see a small iOS app fully authored by you. Once submitted, your code will be reviewed by your potential colleagues, who will dissect it with the same care as if it were a PR to be merged into our codebase. Keep this in mind, as we will equally look at how you approach versioning, as your code style consistency, naming, testing strategy, code layering, architecture, lifecycle gotchas, handling of failures, application of good programming practices etc.
After the review, the reviewers get together and attempt to understand if you could be a good fit for the team. If so, a fun conversation awaits! You’ll be invited to a follow-up interview to discuss the code from your assessment, and all the interesting things related to good programming. If your approach is not to our liking, you’ll still be given feedback about what we did and did not appreciate about the code: this is to make sure you also get something in return for taking the time to do our test.
These are the requirements for our programming assessment:
- Use the Dutch Rijksmuseum API, see documentation here: https://data.rijksmuseum.nl/object-metadata/api/
- We would like the app to have at least two screens:
- An overview page with a list of items (preferably a collection view)
- Should have sections with headers 
- Items should have text and image 
- Page should be paginated
- A detailpage, with more details about the item
- Loading and converting JSON to objects should be asynchronous, a loading icon / animation should be shown
- Automated tests should be present (full coverage not needed off course)
- No SwiftUI, no xib files or storyboards.
Things we will be focussing on when reviewing:
- Architecture used
- Tests written
- Handling of failures (failed network calls, etc)
You’re free to use whichever library you’re used to in your own projects, without limitations. Just give us a heads-up if you reach for something more exotic that heavily impacts what the implementation looks like. After you’re done, send us the link to the repo.
Good Luck!


# Assignment 
- Test app contain 2 screens: Collection screen, Detail screen.
- It use modularization approach so it has 2 swiftpm modules: ImageStorage and RijksmuseumDB
- Main achitecrure design pattern is VIP + Coordinator
- Automated tests represented by unit tests, UI tests, and live tests used for debugging purpose
- To handling and displaying failures it use couple techniques based on level of failures: critical failures display by alert, non-critical display by ui element. The division into types is conventional

## Features
### Collection screen
Collection screen based on UICollectionViewDiffableDataSource and represent list of art objects in RijksmuseumDB.
Although UI part made within simple UIListContentConfiguration it has loading animation for whole list and image also.

### Detail screen
Detail screen or DetailArtObject represent detail information of art object. 
Although, it looks similar to art object from collection screen it use another element inside and can be extended and modified for any requirements.

### RijksmuseumDB
Swiftpm package which represent collection of Rijksmuseum art objects and detail infomation about them. 
Example of usage see in RijksmuseumDB->README.md

### ImageStorage
Swiftpm package provide a simple tool for storing images.


## Other aspects
### Security
Although this aspect is not fully represented in this assignment, I feel it necessary to touch on it. 
ApiKey should be stored more security. 
To choose the best option, it is necessary to determine the requirements. 
In simple words, who are we protecting him from and why

### Testing
In addition to the classical approaches to testing, I applied my personal approach to organizing UI Tests based on Page Object Model + protocols with a default implementation. Although it is still being finalized, I wanted to hear your opinion about it separately.

### Improvements
If I would have more time I add more tests.
I believe this way is the best to find and fix hidden issues. 
I would also add swiftLint and propably github actions.


# Conlusion

This is an exciting test assignment. 
I refreshed my memory on how to work with collections and also learned about the existence of a Rijksmuseum database. 
I would suggest adding some logic to it and UI requirements. 



