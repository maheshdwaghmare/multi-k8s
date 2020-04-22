docker build -t maheshdwaghmare/multi-client:latest -t maheshdwaghmare/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maheshdwaghmare/multi-server:latest -t maheshdwaghmare/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maheshdwaghmare/multi-worker:latest -t maheshdwaghmare/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maheshdwaghmare/multi-client:latest
docker push maheshdwaghmare/multi-server:latest
docker push maheshdwaghmare/multi-worker:latest

docker push maheshdwaghmare/multi-client:$SHA
docker push maheshdwaghmare/multi-server:$SHA
docker push maheshdwaghmare/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maheshdwaghmare/multi-server:$SHA
kubectl set image deployments/client-deployment client=maheshdwaghmare/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maheshdwaghmare/multi-worker:$SHA