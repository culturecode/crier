crier
=====

Simple notification system for the whole town

## Installation

### in your Gemfile

```ruby
gem 'crier'
```

### at the command line

```bash
rake crier:create_tables # not working yet
```

## Usage

```ruby
class User < ActiveRecord::Base
   acts_as_crier
end
```

### Notification Attributes

* crier: Who did the crying
* subject: What they were crying about
* action: What action was being carried out
* scope: A way to group notifications for easy querying
* audience: An optional list of users who can see the notification
* metadata: A hash of metadata to go along with the notification (automatically includes :crier, :subject, :action)

### Public Crying

```ruby
# cry(message, metadata, audience)

someuser.cry("Hello, my name is.")                                # Shout about yourself
someuser.cry("The roof is on fire!", :subject => @house)          # Shout about the house
someuser.cry("Bring out yer dead", :scope => :my_town)            # Shout within a custom scope for finding
someuser.cry("Reticulating Splines", :action => :reticulated)     # Shout with a specific action verb for use in the view
someuser.cry("This is why I'm hot!", :reasons => @reasons)        # Shout with custom metadata
```

### Private Crying

Cries are public unless they have an audience.

```ruby
someuser.cry("Lend me your ears", {}, @other_users)               # Shout only to specific users
someuser.cry("Lend me your ears").to(@other_users)                # Shout only to specific users, alternate syntax, non-transactional
someuser.cry("Lend me your ears").to_others(@other_users)         # Shout only to specific users, alternate syntax, non-transactional, excludes crier from @other_users
```

### Listening

```ruby
Crier::Notification.by(some_user)                                 # Get all the notifications by a particular user
Crier::Notification.heard_by(some_user)                           # Get all the notifications the user heard
Crier::Notification.about(@record)                                # Get all the notifications with the given subject
Crier::Notification.in_scope(:my_town)                            # Get all the notifications within the given scope
```

## Testing

There are multiple gemfiles available for testing against different Rails versions.  Set `BUNDLE_GEMFILE` to target them, e.g.

```bash
bundle install
BUNDLE_GEMFILE=gemfiles/rails_7.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rails_7.gemfile bundle exec rspec
```
