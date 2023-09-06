# Kubernetes 


## Deploy images to Docker Hub

First step in setting up application on the kubernetes cluster 
is to deploy the images to a container registery. Here we use 
Docker Hub. 

```bash
docker tag flask-app_db mehrshadlotfi/flask-app-mysql
docker tag flask-app mehrshadlotfi/flask-app

docker push mehrshadlotfi/flask-app-mysql
docker push mehrshadlotfi/flask-app
```

```yaml title="flaskapp-mysql-service"
apiVersion: v1
kind: Service
metadata: 
  name: flaskapp-mysql
  labels:
    app: flaskapp-mysql
    tier: backend
spec:
  type: ClusterIP
  ports:
  - port: 3306
    targetPort: 3306
  selector:
    app: flaskapp-mysql
    tier: backend
```

```yaml title="flaskapp-mysql-deployment"
apiVersion: apps/v1
kind: Deployment
metadata: 
  name: flaskapp-mysql
  labels:
    app: flaskapp-mysql
    tier: backend
spec:
  replicas: 1
  strategy: 
    strategy: Recreate
  selector:
    matchLabels:
      app: flaskapp-mysql
      tier: backend
  template:
    metadata:
      labels:
        app: flaskapp-mysql
        tier: backend
    spec:
      containers:
      - name: flaskapp-mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: root
        image: flaskapp-mysql:v1 
        ports:
        - containerPort: 3306
```

```yaml title="flaskapp-service"
apiVersion: v1
type: Service
metadata: 
  name: flaskapp
  labels:
    app: flaskapp
    tier: frontend
spec:
  type: NodePort
  ports:
  - port: 5000
  selector:
    app: flaskapp
    tier: frontend
```