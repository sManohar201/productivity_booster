# Windsurf Project

A modern web and mobile application built with Django and React Native.

## Prerequisites

- Python 3.10+
- Node.js 18+
- Docker & Docker Compose
- PostgreSQL
- Redis

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd windsurf-project
```

### 2. Set Up Environment Variables

Copy the example environment file and update the values:

```bash
cp .env.example .env
```

### 3. Start Docker Services

Start PostgreSQL and Redis using Docker Compose:

```bash
docker-compose up -d
```

### 4. Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\activate
   ```

3. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run database migrations:
   ```bash
   cd src
   python manage.py migrate
   ```

5. Create a superuser:
   ```bash
   python manage.py createsuperuser
   ```

6. Run the development server:
   ```bash
   python manage.py runserver
   ```

### 5. Mobile App Setup

1. Navigate to the mobile app directory:
   ```bash
   cd apps/mobile
   ```

2. Install Node.js dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

## Development Workflow

- Run tests: `python manage.py test`
- Format code: `black .`
- Lint code: `flake8`
- Check for security issues: `safety check`

## Project Structure

```
.
├── .github/              # GitHub Actions workflows
├── apps/
│   └── mobile/          # React Native mobile app
├── backend/              # Django backend
│   ├── src/              # Django project source
│   └── requirements.txt  # Python dependencies
├── docs/                 # Project documentation
├── scripts/              # Utility scripts
└── docker-compose.yml    # Docker Compose configuration
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
