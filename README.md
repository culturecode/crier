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

```ruby
someuser.cry("Hello, my name is.")                            # Shout about yourself
someuser.cry("The roof is on fire!", :subject => @house)      # Shout about the house
someuser.cry("Bring out yer dead", :scope => :my_town)        # Shout within a custom scope for finding
someuser.cry("Lend me your ears", :audience => @other_users)  # Shout only to specific users
someuser.cry("Lend me your ears").at(@other_users)            # Shout only to specific users, alternate syntax, non-transactional
someuser.cry("This is why I'm fly!", :reasons => @reasons)    # Shout with custom metadata

Crier::Notification.heard_by(some_user)                       # Get all the notifications the user heard
Crier::Notification.scope(:my_town)                           # Get all the notifications within the given scope
```