# Crewboard Serverpod Migration - Walkthrough

This document outlines the migrated `crewboard` project using Serverpod, including how to run it and what has been implemented.

## Implemented Features

### Data Models
All schema from `crewboard_old` has been migrated to Serverpod `.spy.yaml` models in `crewboard_server/lib/src/models`.
- **User System**: `User`, `UserTypes`, `LeaveConfig`, `Organization`, `SystemColor`
- **Planner System**: `Ticket`, `Bucket`, `Status`, `Priority`, `TicketType`, `BucketTicketMap`
- **DTOs**: `Auth` and `Planner` response objects.

### Endpoints
- **AuthEndpoint**:
  - `signIn`: Authenticates user.
  - `registerAdmin`: Creates new admin user and organization.
  - `checkUsername`: Checks availability.
- **PlannerEndpoint**:
  - `getPlannerData`: Retrieves board layout (Buckets -> Tickets -> Assignees).
  - `addTicket`: Creates tickets, attachments, notifications, and updates bucket mappings.

## How to Run

### Prerequisites
- Docker (Desktop or Engine) running.
- Dart SDK installed.

### Steps
1. Navigate to the server directory:
   ```bash
   cd crewboard/crewboard/crewboard_server
   ```

2. Configure the server:
   - Copy the example passwords file:
     ```bash
     cp config/passwords.yaml.example config/passwords.yaml
     ```
   - Update `config/passwords.yaml` with your own secrets if necessary (defaults are provided for local dev).

3. Start the database (Postgres + Redis):
   ```bash
   docker-compose up --build -d
   ```

3. Create database migration:
   ```bash
   serverpod create-migration
   ```

4. Apply database migrations:
   ```bash
   dart bin/main.dart --apply-migrations
   ```

4. Start the server:
   ```bash
   dart bin/main.dart
   ```

The server will be running at `http://localhost:8080`.

## Verification
- You can use Serverpod Insights (desktop app) to inspect the database and call endpoints.
- Or use `curl` / Postman to hit the API (requires Serverpod serialization format).
