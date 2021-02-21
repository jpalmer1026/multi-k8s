docker build -t jpalmer1026/multi-client:latest -t jpalmer1026/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jpalmer1026/multi-server:latest jpalmer1026/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jpalmer1026/multi-worker:latest -t jpalmer1026/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jpalmer1026/multi-client:latest
docker push jpalmer1026/multi-server:latest
docker push jpalmer1026/multi-work:latest

docker push jpalmer1026/multi-client:$SHA
docker push jpalmer1026/multi-server:$SHA
docker push jpalmer1026/multi-work:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jpalmer1026/multi-server:$SHA
kubectl set image deployments/client-deployment client=jpalmer1026/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jpalmer1026/multi-worker:$SHA