docker build -t chida1234/multi-client:latest -t chida1234/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chida1234/multi-server:latest -t chida1234/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chida1234/multi-worker:latest -t chida1234/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chida1234/multi-client:latest
docker push chida1234/multi-server:latest
docker push chida1234/multi-worker:latest

docker push chida1234/multi-client:$SHA
docker push chida1234/multi-server:$SHA
docker push chida1234/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chida1234/multi-server:$SHA
kubectl set image deployments/client-deployment client=chida1234/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chida1234/multi-worker:$SHA