# tukusi - Website update checker server

tusksi is a website update checker server made with Rails that can control by JSON API.

## Features

- Check updates for HTML documents and JSON documents
- Send notifications to Slack channel HTML documents are processed by nokogiri gem. Please use a headless browser
  renderer like rendertron for SPA pages.

## Setup

Setup your database server with rails commands before starting.

```bash
bundle install
bundle exec rails db:create
bundle exec rails db:schema:load
```

And create your first administrator user by rails console.

```ruby
Api::AdminUserForm.new(
  name: 'username',
  user_level: AdminUser::USER_LEVEL_ADMINISTRATOR,
  email: 'example_user@example.com',
  password: 'your_safe_password_here'
).save!
```

## Usage

Start API server and sidekiq server.

```bash
bundle exec rails server
```

```bash
bundle exec sidekiq
```
