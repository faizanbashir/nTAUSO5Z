### Building docker image
The `Dockerfile` used to build the image is located in the root of the repo.
```shell
docker build . -t faizanbashir/ruby:3.0.2
```

### Pushing to DockerHub
Once the image is built the code can be pushed to Dockerhub or any other repository.
```shell
docker push faizanbashir/ruby:3.0.2
```

### Creating kubernetes objects
The code for the kubernetes objects is stored in the `k8s` directory.
```shell
kubectl create -f k8s/
```

### Checking the status of pods
Once the above command is run you can check to see it the pods are running using the below command and then exit using `CTRL + C`.
```shell
kubectl get po -w
```

### Validating the server
Once the pods are in a running state we can make a curl request to validate the service.
Getting IP address and port for accessing the server on a minikube cluster.

```shell
minikube service server --url=true
```

_**Note:** the server is question exposes a `TCPserver` exposed on port `80`, it does not output any http status code like any standard webserver hence if the url is accessed using the browser it will result in crashing of the server in one of the pods to which the request is routed._

We can use the url obtained from the above command or use the following `curl` command:

```shell
curl $(minikube service server --url=true)
```

The output should be:
```shell
Well, hello there!
```

### Strategy/Architecture

The deployment is running `3` replicas of the same pod for high availability and the `loadBalacer` service distributes the incoming traffic between them. The deployment strategy is set to `rollingUpdate` with a `maxSurge` set to `1` which means that there will be at most `4` pods during the update process if replicas is `3` and `maxUnavailable` set to `1` which means that there will be at most `1` pod unavailable during the update process.

### Connecting to the application

We can connect to the application using `curl`, as shown previously:

```shell
$ curl $(minikube service server --url=true)
```

We can also connect to it using `telnet`:

```shell
$ telnet <ip-address> <port>
```

Since this is a non standard webserver and does not output any status codes we wont be able to connect it using the browser or any other mechanism which checks for a status code.