# Matchpoint API

A Ruby on Rails GraphQL API for a dating/matching application.

## Requirements

- Ruby 3.4.1 (Download "Ruby+Devkit 3.4.1-1 (x64)" from [rubyinstaller.org](https://rubyinstaller.org/downloads/))
- Rails
- Bundler
- PostgreSQL

Verify:

```sh
ruby -v
rails -v
psql --version
```

## Setup

```sh
cd matchpoint-api
bundle install
rails db:create db:migrate db:seed
rails server
```

The GraphQL API will be available at:

```sh
http://localhost:3000/graphql
```

## Design Rules

- **Colors**: Solid colors only (no gradients)
  - Primary: #3B82F6 (Blue)
  - Success: #22C55E (Green)
  - Danger: #EF4444 (Red)
  - Neutral: #F3F4F6 / #FFFFFF
- **Location**: Province and City (Philippines)
- **No emojis** in UI, comments, or seeds
