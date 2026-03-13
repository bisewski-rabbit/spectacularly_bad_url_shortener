# URL Shortener - Code Review Exercise

A simple URL shortener Rails application for code review practice.

## Setup

```bash
cd interview_url_shortener
bundle install
rails db:create db:migrate
rails server
```

## API Endpoints

- `GET /urls` - List all URLs
- `POST /urls` - Create shortened URL (params: original_url)
- `GET /:short_code` - Redirect to original URL
- `GET /stats/:short_code` - View URL statistics
- `DELETE /urls/:id` - Delete a URL

## Interview Task

Review this codebase and identify issues related to:
- Security vulnerabilities
- Performance problems
- Code correctness bugs
- Maintainability concerns
- Missing best practices

Good luck!

