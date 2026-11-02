# Healthie Backend

Rails application modeling providers, clients, their enrollments, and client journal entries. This repository covers the backend portion of the pairing exercise, with standard ERB scaffold forms for interacting with the data.

## Requirements

- Ruby 4.0.9
- Bundler
- SQLite3

The application uses Rails 8.1.4.

## Local setup

From the repository directory:

```sh
bundle install
bin/rails db:prepare
bin/rails server
```

Open one of these pages:

- Providers: http://localhost:3000/providers
- Clients: http://localhost:3000/clients
- Enrollments: http://localhost:3000/enrollments
- Journal entries: http://localhost:3000/journal_entries

There is no custom home page or seed data. Create providers and clients first. The enrollment and journal forms accept their numeric IDs; enrollments accept `basic` or `premium` as the plan.

## Tests

```sh
bin/rails test
```

Tests cover CRUD actions, enrollment plan validation, duplicate enrollment rejection, the required association queries, and journal ordering.

## Data model

- **Provider:** name and email; has many clients through enrollments.
- **Client:** name and email; has many providers through enrollments and has many journal entries.
- **Enrollment:** connects one provider and one client, with a `basic` or `premium` plan.
- **JournalEntry:** belongs to a client and contains freeform text in `body`.

The plan belongs to the enrollment because a client can have different plans with different providers. A scoped model validation and a unique database index prevent duplicate provider–client pairs.

Journal entries are ordered by creation timestamp, newest first, with descending ID as a tie breaker.

## Required queries

Start a console:

```sh
bin/rails console
```

Select existing records, then run the queries:

```ruby
provider = Provider.first!
client = Client.first!

# All clients for a provider
provider.clients

# All providers for a client
client.providers

# All journal entries for a client, newest first
client.journal_entries.newest_first

# All journal entries across a provider's clients, newest first
provider.journal_entries.newest_first
```

## Current behavior and scope

Names and emails have no uniqueness constraints. Deletion is permanent: deleting a provider removes its enrollments while preserving clients and their journal entries. Deleting a client removes its enrollments and journal entries.

A provider's journal query uses current enrollments and includes all entries belonging to those clients, including entries created before enrollment.

The UI uses basic Rails scaffold forms. Authentication, pagination, and historical enrollment tracking are outside this implementation.
