# pull official base image
FROM python:3.11.6-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0


# install dependencies
# COPY ./Pipfile .
# COPY ./Pipfile.lock .
# RUN pip install pipenv
# RUN pipenv sync

COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

RUN python manage.py collectstatic --noinput

# add and run as non-root user
RUN adduser -D myuser
USER myuser

EXPOSE 8000

# CMD gunicorn config.wsgi:application --bind 0.0.0.0:$PORT
CMD gunicorn config.wsgi:application --bind 0.0.0.0:8000
