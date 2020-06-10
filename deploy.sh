# Use the GIT SHA as an identifier, Great for quick rollback. 
# Keep the latest tag for building 

# Secret for Postgres is set as env var on the GKE cloud shell
# > gcloud config set project fib-docker-kubernetes
# > gcloud config set compute/zone europe-west1-b
# > gcloud container clusters get-credentials fib-docker-kubernetes

docker build -t razik/fib-client:latest -t razik/fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t razik/fib-server:latest -t razik/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t razik/fib-worker:latest -t razik/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push razik/fib-client:latest
docker push razik/fib-server:latest
docker push razik/fib-worker:latest

docker push razik/fib-client:$SHA
docker push razik/fib-server:$SHA
docker push razik/fib-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=razik/fib-server:$SHA
kubectl set image deployments/client-deployment client=razik/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=razik/fib-worker:$SHA