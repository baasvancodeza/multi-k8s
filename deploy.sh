docker build -t baasvancodeza/multi-client:latest -t baasvancodeza/multi-client:$SHA ./client
docker build -t baasvancodeza/multi-server:latest -t baasvancodeza/multi-server:$SHA ./server
docker build -t baasvancodeza/multi-worker:latest -t baasvancodeza/multi-worker:$SHA ./worker
# Push to dockerhub
docker push baasvancodeza/multi-client:latest
docker push baasvancodeza/multi-client:$SHA
docker push baasvancodeza/multi-server:latest
docker push baasvancodeza/multi-server:$SHA
docker push baasvancodeza/multi-worker:latest
docker push baasvancodeza/multi-worker:$SHA
# deploy k8s
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=baasvancodeza/multi-server:$SHA
kubectl set image deployments/client-deployment client=baasvancodeza/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=baasvancodeza/multi-wroker:$SHA

