#!/bin/bash
# Створення тимчасових каталогів для файлів веб-сайту
mkdir -p tempdir/templates tempdir/static
echo "tempdir directories created."

# Копіювання файлів веб-сайту та sample_app.py у tempdir
cp sample_app.py tempdir/
cp templates/index.html tempdir/templates/
cp static/style.css tempdir/static/

# Генерація Dockerfile у tempdir
echo "FROM python:3.9-slim"                                       >  tempdir/Dockerfile
echo "RUN pip install flask"                                      >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/sample_app.py"               >> tempdir/Dockerfile
echo "COPY templates/index.html /home/myapp/templates/index.html" >> tempdir/Dockerfile
echo "COPY static/style.css /home/myapp/static/style.css"         >> tempdir/Dockerfile
echo "EXPOSE 8080"                                                >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py"                      >> tempdir/Dockerfile

# Збірка контейнера Docker
cd tempdir
docker build -t sampleapp .

# Запуск контейнера та перевірка
docker run -t -d -p 8080:8080 --name samplerunning sampleapp
docker ps -a
