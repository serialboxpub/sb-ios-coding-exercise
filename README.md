# Serial Box iOS Coding Exercise #
We would like to thank you for taking the time to complete this exercise. We believe this to be an effective and efficient way to allow you to showcase your skills without the pressure of someone watching you. Your code will be used to assist us in deciding if we'd like to proceed further with the interview process. Please understand that completing this exercise in no way guarantees a job or follow-up interview(s). If we choose to move forward with you in the process, we will schedule an additional interview with you to step through your submission as well as cover a range of technical and social aspects relevant to working at Serial Box.

NOTE: We will keep you posted regardless after you have completed and submitted the exercise.

### Exercise Overview ###
* All your code should be written in **Swift**
* Please see the "Starter App Overview" and "Task List" sections below for instructions for completing this exercise. There will also be additional comments placed within the starter project's code to help direct you.
* Everyone's time is valuable. We designed this exercise with the expectation it would take you no longer than 1-2 hours maximum, but hopefully less, to complete.
* Once you start, there is no set due date for completing and submitting the exercise. However, since we are actively interviewing, the longer you take to submit, the greater the chance that we'll move forward with other candidates.  We'll presume any forks greater than 7 days old without a submitted PR will not be completed/submitted.
* If you run into issues getting set up or submitting your work, feel free to email me directly and I'll try to respond as quickly as I can.

### Getting Set Up ###
1. **FORK** this repository to your own github account
2. Clone the repo via `git clone git@github.com:<YOUR_GITHUB_ACCOUNT>/sb-ios-coding-exercise.git` or your favorite git client
3. From your cloned fork, create a new branch named with the following format: `firstName_lastName_ratings`
4. Open `Recommendations.xcworkspace` and build and run.  If it builds and runs successfully, you can skip the remaining steps (5-7) here and are ready to begin completing the task list. If it fails to build and run, continue to the next step.
5. If you don't have [Cocoapods](https://cocoapods.org/about) installed, install it with the following commands:
  * `sudo gem install cocoapods`
  * Restart your terminal
  * `pod setup`
6. `pod install`
7. Open `Recommendations.xcworkspace` and build and run. The project should compile and run.


### Submission Instructions ###
* Complete all tasks as outlined in "Task List" and create a pull request (PR) pointing at **YOUR** fork's `master` or `develop` (your choice, either is fine) branch.
* Add `@kerryknight` as a contributor on your fork and also tag `@kerryknight` on your PR description when you open it.
* If you'd like to include comments to explain your code in any way, please feel free to do so within the code itself or in your PR.

### What are we looking for? ###
Keep it simple. Read the task list, requirements and restrictions carefully and focus on solving the problem to the best of your ability.

Treat this code like production code. That is, develop your solution in the same way that you would for any code that is intended to be deployed to production. This may be a toy exercise, but we really would like to get an idea of how you build for iOS on a day-to-day basis.
--

### Starter App Overview ###
Serial Box produces serialized fantasy and science fiction stories in text and audio formats. The goal of this app exercise is to create a top-10 list of recommended titles for the app user, with recommendations sorted from highest rating to lowest rating.  We'll base this top-10 list on the titles with the highest ratings, being sure to exclude any titles the user already owns or has previously skipped over. Titles that have not been released yet should also be excluded.

For the purpose of this exercise, we will simulate making a network request to our server to retrieve a list of all our titles. The starter project includes a json file `ratings.json` which contains: 
 * a contrived array of many of our titles, with information about whether the titles have been released, what their overall rating is, a cover art url, and the title's tagline.
 * an array of titles the user already owns (see `titles_owned`)
 * an array of titles the user has skipped or passed on (see `skipped`)

NOTE: To simulate the network request, the starter project uses [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) to stub the response with the included `ratings.json` file. The stubbed network response (handled in `Stub.swift`) has intentionally been set up with a slight delay to better simulate true network conditions. You do not need to modify anything in `Stub.swift`, you just need to ensure the stubbed response setup remains in place and that the same URL is used to call the provided URLSession dataTask.
--

## Task List ##
1. The stubbed network request is returning the local file `ratings.json` in its callback. There is extremely crude json parsing code in place to facilitate populating the tableview with data to start. You should improve upon parsing the response's json in whatever manner you see fit.
2. The `RecommendationTableViewCell`'s `taglineLabel` is not fully displaying all the title's tagline text. Without modifying the font size, please ensure the cell resizes as needed so that the full tagline can be displayed. The intended positioning of all other cell components should remain unchanged.
3. The app only needs to run in the iOS simulator (so don't worry about provisioning for testing on a real device for this exercise, unless you really want to :)). However, please ensure the recommendation list displays properly in all orientations on various devices and screen sizes. The provided UILabels' font sizes do not need to be altered.
4. When scrolling the initial list of recommendations, the tableview's scrolling is not smooth. Please find and fix the source of the jank so that the list scrolls smoothly.
5. Based on the data in `ratings.json`, build a top-10 list of recommendations, sorted from highest rating to lowest rating. The list of recommendations should not include any title where `is_released == false`.  Titles that the user already owns or has skipped over previously should also be excluded from the list. Each recommendation's pertinent data should be displayed in the tableview cell provided.  This obviously means there should only be 10 populated rows in your completed app.
6. Finally, you'll notice that when you first open the app, there is nothing but an empty screen for a couple seconds. This is by design to simulate slower network conditions. After building your recommendation list, you should cache the list and persist it so that when the app is run again, the tableview is immediately populated from your cached results and then updated again once the true (simulated) network response returns and recommendation list is rebuilt. It's fine that these lists may be the same.
 
 ### Additional Requirements/Restrictions ###
 * Only Apple-provided iOS APIs may be utilized. No additional 3rd party dependencies should be used.
 * Unless otherwise specified in this README or the code comments, you can make any changes you need/want to the starter project's files (excluding `AppDelegate.swift`, `Stub.swift` or `ratings.json`), so long as all exercise requirements are still met. The starter project's implementation is simply set up for you as a baseline, so you can reorganize/rewrite/refactor/add as you see fit. However, basic project components like the provided UITableView, the stubbed network request, and the provided UITableViewCell subclass must remain and be utilized.
 * Your code should be robust, maintainable and include any/all optimizations, error handling, etc. as you see fit.
--

 Thanks again for taking the time to complete this exercise.  Good luck!