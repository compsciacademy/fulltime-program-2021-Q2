# Day 55
  
## Storage with Rails  
  
In our Projects project, we want to be able to add a Photo (or maybe a list of photos, ala a [carousel](https://getbootstrap.com/docs/5.0/components/carousel/)) to a project.  

---

Active Storage allows us to attach files to Active Record models. To install it, run:

```
bin/rails active_storage:install
```

This will generate a migration to create 3 tables that Active Storage uses, `active_storage_blobs`, `active_storage_variant_records`, `active_storage_attachments`.  

We can edit the `config/storage.yml` with the appropriate settings for the storage provider we are using.

```yaml
# Use rails credentials:edit to set the AWS secrets (as aws:access_key_id|secret_access_key)
amazon:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-1
  bucket: your_own_bucket
```

Set the environment config to use the appropriate storage provider. For example:

To store files locally:
```ruby
config.active_storage.service = :local
```

To use amazon
```ruby
config.active_storage.server = :amazon
```

Let's start out by adding an image attachment to users, we can call it `:profile_photo` or whatever we want, really. We can set it up, and make sure things are working locally, and then move on to use S3 instead.

We'll add a `has_one_attached` macro to the User model
```ruby
class User < ApplicationRecord
  validates :email, presence: true
  has_one_attached :profile_photo
  has_many :comments, as: :commentable
  has_many :discussions
  has_many :projects
  devise :database_authenticatable, :registerable
end
```

Generate a migration to add the `profile_photo` field to users:
```
bin/rails generate migration AddProfilePhotoToUser profile_photo:attachment
```

Add a form field for it, on the user registration `new.html.erb` and `edit.html.erb` `<%= form.file_field :profile_photo %>`   
  
We need to accept the new parameter in our controller, which is handled through [Devise](https://github.com/heartcombo/devise#strong-parameters), so we can configure a before action in our application controller that uses Devise's `devise_parameter_sanitization` method to permit additional fields:

```ruby
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_photo])
  end
end

```