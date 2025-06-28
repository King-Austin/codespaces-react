#!/bin/bash

# Navigate to the backend directory
cd /workspaces/codespaces-react/backend

# Make migrations for the database
echo "Making migrations..."
python manage.py makemigrations

# Apply migrations
echo "Applying migrations..."
python manage.py migrate

# Create a superuser (non-interactive)
echo "Creating superuser..."
if python manage.py shell -c "from django.contrib.auth.models import User; User.objects.filter(username='admin').exists()" | grep -q "False"; then
    python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'adminpassword')"
    echo "Superuser created with username: admin, password: adminpassword"
else
    echo "Superuser 'admin' already exists"
fi

# Run the server
echo "Starting Django development server..."
python manage.py runserver 0.0.0.0:8000
