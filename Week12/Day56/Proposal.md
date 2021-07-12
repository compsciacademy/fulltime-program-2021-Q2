# Post & Lintel

## Abstract

_In architecture, post and lintel (also called prop and lintel or a trabeated system) is a building system where strong horizontal elements are held up by strong vertical elements with large spaces between them. This is usually used to hold up a roof, creating a largely open space beneath, for whatever use the building is designed. The horizontal elements are called by a variety of names including lintel, header, architrave or beam, and the supporting vertical elements may be called columns, pillars, or posts. The use of wider elements at the top of the post, called capitals, to help spread the load, is common to many traditions. (wikipedia)_

 P/L (Post and lintel) is a portal for community leaders - allowing short and long posts, and events. The bridge for community leaders to communicate and share concerns, events, and other viable forms of information - specific to time and place.

Unique to P/L is the the interactivity of users to user generated events with blog systems. Users of P/L are able to create content - without the restrictions and limitations of such platforms as FaceBook and Meetup! 

It will be the one place.

# Features

* Account creation and management
* Post, Status, Event creation by community members
* Individual and personalized feeds
* Profile pages: containing user biography, posts, activity.
* Email on activity: alerts on particular events such as new events and/or comments

# Models

## User

### Description: 

Registration, validation through Devise gem.
Ability to create an account for full functionality of Lintel - to post, interact with posts, edit ones posts, create events, view events, edit ones events, login, logout, edit profile.

### Fields: 

(priority fields)
- :user_name (string, unique, under 50 chars, does not contain special chars)
- :email (string, unique (no duplicates), must be valid)
- :password (string, unique and encrypted)
- :user_id (integer, unique, generated)

(secondary fields)
- :location (string, 'selectable')
- :birthday (string)
- :profile_photo (data)
- :short_bio (string, under 256 chars)
- :profile_bio (string)

### Model relationships:

- has_many :blog_posts
- has_many :status_posts
- has_many :events
- has_many :photos
- has_many :friendship

## Friendship

### Description:

Friendship a model that articulates the relationship between users of P/L.

A friendship allows users to closely follow the activity of others in their personalized 'feeds'.

### Fields
- :user_id (string)
- :friend_id (string)

### Model Relationship
- belongs_to :users

## Blog_Post

### Description:
Blog posts are long-form bodies of text and image. 

A blog post body is feature rich-featured text and ability to accept images to be rendered in display.

The blog post should contain a title and body - created and associated with a user. A user can have many blog posts.

### Fields:
- :title (string, under 250 char)
- :body (string)

### Model Relationships:
- belongs_to :user
- has_many :likes, as: :likeable
- has_many :dislikes, as: :dislikeable
- has_many :comments, as: :commentable
- has_many :photos

## Status_Post

### Description: 
Similar to blog posts, status posts are 'small' posts with a restriction of 256 characters.

A status post is created and and associated with a user. A user can have many status posts.

These posts can be coupled with images.

They are likable, dislikable, and commentable - meaning they can contain comments.

### Fields:
- :body (string, under 256 char)
- :photos (data)

### Model Relationships:
- has_many
- has_many :likes, as: :likeable
- has_many :dislikes, as: :dislikeable
- has_many :comments, as: :commentable

## Comment

### Descriptions:
Comments allows users to interact and communicate through posted text on posts, statuses, events.

Every comment must be created by a user and must have an association to a blog post, status or event. Every blog post, status post, or event can have many comments.

Every comment is likable and dislikable by users.

### Fields:
- :body (string)

### Model Relationships:
- belongs_to :blog_posts
- belongs_to :status_posts
- belongs_to :comments
- has_many :likes, as: :likeable
- has_many :dislikes, as: :dislikeable

## Event

### Description:
Events are what P/L are made for.

A user is able to create an event. An event can be associated with several users.

Every event is likable, dislikable, and commentable by users.

### Fields:
:title (string, less than 256 chars)
:body (rich text)
:start_date (date)
:end_date (date)
:start_time (date)
:end_time (date)
:location (string, selectable in view)

### Model Relationships:
- belongs_to_and_has_many :users
- has_many :likes, as: :likeable
- has_many :dislikes, as: :dislikeable
- has_many :comments, as: :commentable

## Likeable / Dislikeable

### Description:

Likeable and dislikeable are a feature that allows users to interactand express their agreeable-ness, disagreeable-ness or passive-ness with a Facebook-style thumbs up and thumbs down on posts, comments, and events.

A user can apply one or the other on the associated post or comment.

A 'like' or 'dislike' is reversible.

### Fields (for each):
- :is_likeable / :is_dislikeable (boolean)

### Model Relationships:
- belongs_to :blog_posts
- belongs_to :status_posts
- belongs_to :comments
- belongs_to :events

## Photo

### Description:

Photos are images that are uploaded, editable and deltable by users.

Photos can have an association to blog posts, status posts, and events.

Photos are managed by Rails ActiveStorage and stored using Amazon S3.

### Model Relationships:
- belongs_to :user

# Views

## Landing page (view/landing)

### Description:
The landing home page of P/L. Contains useful and pogiant information. Gives ability for current users to log in, or future users to create account.

 - Contains:
    - Description of website
    - Login
    - Account Creation
    - View public events

## New account (user/signup)

### Description:
 Permits and validates user information through form. Must validate and create accounts under Devise model. Sucessful login redirects to _user feed_.

## Account login (user/login)

### Description:
Permits and validates account information through form. Sucessful login redirects to _user feed_.

## User home feed (username/feed)

### Description:
Shows subscribed content - or all content from other users. This includes statuses, blog posts, and events. The feed by default is organized by date of creation - the newest content first. Each with link respected show element

The home feed should give easy access to the ability to create status post and/or blog post.

## User profile page (username)

### Description:
Shows the activity and information of one's profile.
Gives the ability to subscribe as friend.

## Post creation (blog_post/new)

### Description:
Allows user to create rich-text blog posts.

## Status creation (status_post/new)

### Description:
Allows user to create status posts.

## Events feed (events)

### Description:
Similar to the user home feed, events feed is a filetered view of posted events from other users.

## Event creation (event/new)

### Description:
Gives form of creation for new event for users.

## Event view (event/:id)

### Description:
Gives view to selected event. Gives user/viewer ability to attend event. 

---

# Other Features
  
- ActionMailer: Users should receive email notifications when a post of theirs is liked.  

---


# Expected Dependancies
### 
- Ruby on Rails (with emphasis on ActionMailer, ActiveRecord, ActiveStorage, ActionText)
- AWS3
- Devise
- Bootstrap
- Popper.JS


# Somethings I need to consider
- Organizing and staging photos throughout the models
- Rich-text and styling (through Action Text)
- What database should I utilize? What is an approach for me, the novist pushing to Heroku?
- Storage on S3
- Testing of models, views, controllers
- Taking it from development and pushing it to production
- Filtering, styling through Javascript
- Using React Components?

# Future Plans
- Customizable e-mail subscription (feeds, comments, analytics)
- Photo albums, bulk upload
- Rich-text for codes
- Tagging system
- Scheduled events (messages and filters)

# Links for myself

- [Day26: On Heroku](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day26)
- [Day51: Polymorphic association (and such)](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week11/Day51)
- [Week11: Rails](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week11)
