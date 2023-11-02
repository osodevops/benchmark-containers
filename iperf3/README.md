# Deploying iperf3 in Kubernetes
This guide assumes that you have a Kubernetes cluster up and running and that you are familiar with the basics of Kubernetes resource management using kubectl.

## Deployment Overview
iperf3 is a well-known network testing tool that is commonly used for measuring the maximum network bandwidth (throughput) between two network endpoints. It is invaluable for network performance analysis and is widely utilized for tuning and troubleshooting by network engineers.

The provided iperf3-job.yaml file creates a Kubernetes Job that runs iperf3 in server mode or client mode, depending on your configuration. This allows for a flexible setup to test various network links within your Kubernetes cluster.

## Job Execution
The iperf3 Job will:

Launch an iperf3 Server Pod: If configured in server mode (-s), it listens for incoming connections from an iperf3 client.

Initiate an iperf3 Client Pod: If configured in client mode (-c <server>), it connects to the specified iperf3 server pod or service and starts the test.

Each instance of the Job runs to completion, ensuring that the network performance test is a one-off operation. Once the test concludes, the pod logs can be retrieved to analyze the results of the network performance test.

## Customization for Specific Tests
You may adjust the iperf3 parameters to match the specific network performance characteristics you wish to test. This is done by modifying the arguments in the args section of the iperf3 Job YAML file. The iperf3 tool offers a variety of command-line options to tailor your testing, such as adjusting the time of the test, the packet size, or the port number.

## Running iperf3
On the assumption that you are using minikube, we have included a script called `build-iperf.sh` which will make use of the `Dockerfile` contained within this folder, build it, and make it available to minikube.

### Building iperf3
``` sh
./build-iperf.sh
```

### Deploying iperf3 server
``` sh
kubectl apply -f iperf3-server-deployment.yaml
```

### Deploying iperf3 client
``` sh
kubectl apply -f iperf-job.yaml
```

### Check the status of the Job with:
``` sh
kubectl get job iperf3-client-job
```

Once the Job has completed, you can also check the logs of the pod to see the output of the iperf3 command:
### First find the pod name and save to an ENV VAR
``` sh
POD_NAME=$(kubectl get pods -l job-name=iperf3-client-job -o jsonpath='{.items[0].metadata.name}')
```

### Then check the logs
``` sh
kubectl logs $POD_NAME
```
After a successful run, you should see something like this:
``` sh
➜  kubectl logs $POD_NAME
Connecting to host iperf3-server, port 5201
[  5] local 10.244.0.35 port 38914 connected to 10.102.33.39 port 5201
[  7] local 10.244.0.35 port 38926 connected to 10.102.33.39 port 5201
[  9] local 10.244.0.35 port 38932 connected to 10.102.33.39 port 5201
[ 11] local 10.244.0.35 port 38948 connected to 10.102.33.39 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-5.00   sec  10.4 GBytes  2137 MBytes/sec    0   1022 KBytes
... <READACTED FOR BREVITY> ...
[SUM]  55.00-60.00  sec  42.2 GBytes  8639 MBytes/sec  1096
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-60.00  sec   124 GBytes  2113 MBytes/sec  1260             sender
[  5]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec                  receiver
[  7]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec  3701             sender
[  7]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec                  receiver
[  9]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec  1133             sender
[  9]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec                  receiver
[ 11]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec  2669             sender
[ 11]   0.00-60.00  sec   124 GBytes  2112 MBytes/sec                  receiver
[SUM]   0.00-60.00  sec   495 GBytes  8449 MBytes/sec  8763             sender
[SUM]   0.00-60.00  sec   495 GBytes  8448 MBytes/sec                  receiver

iperf Done.

```