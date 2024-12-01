FROM python:3

# set the working directory
WORKDIR /app

# copy files form host system to image
COPY . /app

# install the necessary packages
RUN apt-get update && apt-get install -y python3.5

# set environment vaariables
ENV NAME world

# run a command
CMD ["python3.5", "app.py"]