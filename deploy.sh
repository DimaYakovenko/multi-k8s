docker build -t dyakodocker/multi-client:latest -t dyakodocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dyakodocker/multi-server:latest -t dyakodocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dyakodocker/multi-worker:latest -t dyakodocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dyakodocker/multi-client:latest
docker push dyakodocker/multi-server:latest
docker push dyakodocker/multi-worker:latest

docker push dyakodocker/multi-client:$SHA
docker push dyakodocker/multi-server:$SHA
docker push dyakodocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=dyakodocker/multi-client:$SHA
kubectl set image deployments/server-deployment server=dyakodocker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dyakodocker/multi-worker:$SHA
