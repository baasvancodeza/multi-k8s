docker build -t baasvancodeza/multi-client:latest -t baasvancodeza/multi-client:$SHA ./client
echo "Step 1"
docker build -t baasvancodeza/multi-server:latest -t baasvancodeza/multi-server:$SHA ./server
echo "Step 2"
docker build -t baasvancodeza/multi-worker:latest -t baasvancodeza/multi-worker:$SHA ./worker
echo "Step 3"
# Push to dockerhub
docker push baasvancodeza/multi-client:latest
echo "Step 4"
docker push baasvancodeza/multi-client:$SHA
echo "Step 5"
docker push baasvancodeza/multi-server:latest
echo "Step 6"
docker push baasvancodeza/multi-server:$SHA
echo "Step 7"
docker push baasvancodeza/multi-worker:latest
echo "Step 8"
docker push baasvancodeza/multi-worker:$SHA
echo "Step 9"
# deploy k8s
kubectl -f k8s
echo "Step 10"
kubectl set image deployments/server-deployment server=baasvancodeza/multi-server:$SHA
echo "Step 11"
kubectl set image deployments/client-deployment client=baasvancodeza/multi-client:$SHA
echo "Step 12"
kubectl set image deployments/worker-deployment worker=baasvancodeza/multi-wroker:$SHA
echo "Step 13"
