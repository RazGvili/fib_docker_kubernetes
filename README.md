*Part of a Docker course - "docker-and-kubernetes-the-complete-guide" by the great Stephen Grider

## Purpose
This app calculates the value of a Fibonacci value given an index of the series. Example: For the index 6 the value is 13.

## CI
The master branch is integrated into TravisCI, a successful deploy must pass the react app tests. 
After success, a script will build and push to docker hub + set a new image to a k8s cluster deployed on GKE. 

# App architecture

## Components

### External load balancer 

### Nginx-Ingress 

### Client k8s Deployment exposed via ClusterIp service 
returns create-react-app static files 

### Express server k8s Deployment exposed via ClusterIp service 
API for Fibonacci calculations. Will save indices the app seen in a Postgress DB. The calculated values will first be saved as "ready", then will be passed to the worker container. 

## Worker k8s Deployment
Listens to the saved Redis values (Pub/Sub), then calculates the Fibonacci value. 

## Redis Deployment exposed via ClusterIp service 

## Postgres Deployment exposed via ClusterIp service with PVC

