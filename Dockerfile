# our base image
FROM python:3.12-rc-slim-buster

WORKDIR /app
# upgrade pip
RUN python -m pip install --upgrade pip

# install Python modules needed by the Python app
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy files required for the app to run
COPY main.py .
COPY templates/ ./
COPY templates/index.html templates/index.html
COPY static/style.css static/style.css
COPY static/main.js static/main.js

# tell the port number the container should expose
EXPOSE 5500

# run the application
CMD ["python", "main.py"]