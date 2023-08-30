# Containerize applications

## Project structure
We use the following layout for our project.
  
  ```bash
  web/
  ├── app
  │   └── app.py
  │   └── app.Dockerfile
  ├── db
  │   └── init.sql
  └── docker-compose.yml
  ```

<details>
<summary>
<p>

**app.py** — contains the Flask app which connects to the database and exposes one REST API endpoint
</p>
</summary>
<p>

```python title="app/app.py"
from typing import List, Dict
from flask import Flask
import mysql.connector
import json
app = Flask(__name__)
def favorite_colors() -> List[Dict]:
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'knights'
    }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM favorite_colors')
    results = [{name: color} for (name, color) in cursor]
    cursor.close()
    connection.close()
    return results
@app.route('/')
def index() -> str:
    return json.dumps({'favorite_colors': favorite_colors()})
if __name__ == '__main__':
    app.run(host='0.0.0.0')
```

</p>
</details>

<details>
<summary>
<p>

**app.Dockerfile** — a Dockerfile for the Flask app
</p>
</summary>
<p>

```Dockerfile title="app/app.Dockerfile"
FROM python:3.6

EXPOSE 5000

WORKDIR /app

COPY ./requirements.txt /app
RUN pip install -r requirements.txt

COPY app.py /app
CMD python app.py
```
</p>
</details>

<details>
<summary>
<p>

  **init.sql** — an SQL script to initialize the database before the first time the app runs
</p>
</summary>
<p>

```sql title="db/init.sql"
CREATE DATABASE knights;
use knights;

CREATE TABLE favorite_colors (
  name VARCHAR(20),
  color VARCHAR(10)
);

INSERT INTO favorite_colors
  (name, color)
VALUES
  ('Lancelot', 'blue'),
  ('Galahad', 'yellow');
```
</p>
</details>

There are two ways to build the images for the Flask app, and run the application. 
The first is to build it using the docker build command, 
and the second is to build it using the docker-compose.yml file. 

### Build the image using docker build command
1. Create a network for the containers to communicate with each other, and run the MySQL container:
```bash
cd db
docker network create flask-app
docker run --net flask-app --name db --hostname db    \
  -it -v .:/docker-entrypoint-initdb.d/:ro            \
  -e MYSQL_ROOT_PASSWORD=root -p 32000:3306 mysql:5.7
```

2. Build the image for the Flask app and run it:
```bash
cd app
docker build -t flask-app:latest -f app.Dockerfile .
docker run --net flask-app --name app --hostname app -it -p 5000:5000 flask-app:latest
```

### Build the image using docker-compose.yml

1. Create a docker-compose.yml file in the root directory of the project:
```yaml title="docker-compose.yml"
version: "2"
services:
  app:
    build: 
      context: ./app
      dockerfile: app.Dockerfile
    links:
      - db
    ports:
      - "5000:5000"
  db:
    image: mysql:5.7
    ports:
      - "32000:3306"
    environment:
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - ./db:/docker-entrypoint-initdb.d/:ro
```

## References 
* https://stavshamir.github.io/python/dockerizing-a-flask-mysql-app-with-docker-compose/