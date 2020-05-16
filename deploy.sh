docker build -t tranvancong/multi-client:latest -t tranvancong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tranvancong/multi-server:latest -t tranvancong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tranvancong/multi-worker:latest -t tranvancong/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tranvancong/multi-client:latest
docker push tranvancong/multi-server:latest
docker push tranvancong/multi-worker:latest

docker push tranvancong/multi-client:$SHA
docker push tranvancong/multi-server:$SHA
docker push tranvancong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tranvancong/multi-server:$SHA
kubectl set image deployments/client-deployment client=tranvancong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tranvancong/multi-worker:$SHA