# Day 56  
  
Final Project  
-------------   
  
You have a chance to work on your own portfolio app. If you have something in mind that you'd prefer to work on, that highlights a majority of the things we've covered, then feel free to do so, otherwise, have a look at the following suggestion.  
  
Write an application where people can sign up for an account, build out a profile page for themselves, with a profile photo, post either in the short-feed posts (small messages, up to 256 characters) or in the long-form post style (like a blog post).  
  
Users should be able to like and/or upvote and/or downvote posts from other users. There should also be the ability to friend and/or follow users.  
  
Users should receive email notifications when a post of theirs is liked.  

**BONUS** (Stretch Goals):  
  
Try to think through the situations where it makes sense to send email notifications, e.g. should we send email for every time a post is liked, a person if followed or a friend-request is sent, etc.?  
  * Allow users to have settings where they decide how often to receive which updates.  
  * Show a history of profile pictures.
  * Allow for photo albums
  * Add syntax highlighting for code snippets in both long and short form posts
  * Tags -- polymorphic
  * Scheduled events
    - sends messages to followers
    - filter events by tags/interests
    - etc.
  * etc.


## Proposal Based Rewrite of Project  
  
The new MVP list is going to focus around Events, and Organizations (or Clubs). Users can create Organizations, and also join organizations as members. Organizations have events. A member of an organization can be notified (emailed) when a new event is created, and they should be able to sign up to attend the event.  
  
Members of an organization should be able to comment on an organizations' event.

Events should have a Photo, Description, Location, Day/Time. And of course a list of attendees.
  
Users should also have a User Profile, a user's profile can have a photo of the user, a description or tagline, a list of interests, list or organization memberships, list of events, list of comments, list of likes recieved and given.  
  
**BONUS** (Stretch Goals):  
  
  * Users should be able to create long-form posts. Which can also be _events_, that are not attached to an org.
  * Users should be able to follow or friend other users.
  * Users should also be able to create short-form posts (256 chars), which can include links or Thumbnail photos.
  * Tags: Posts and Events should be _taggable_, such that a tag can be added to them, which can also be used to filter them in a search.
    - This can be used to suggest events, posts, or users to follow based on a user's interests
  * Rich-text editing for events and all posts.
  