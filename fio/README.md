# Deploying FIO in Kubernetes
This guide assumes that you have a Kubernetes cluster up and running and that you are familiar with the basics of Kubernetes resource management using kubectl.

## Deployment Overview
To leverage FIO for benchmarking storage performance in a Kubernetes environment, we have provided a YAML definition file for a Kubernetes Job resource. This Job is responsible for creating a pod that will execute a one-time FIO workload, simulating the specified I/O patterns and operations, and then terminate.

## Running FIO
On the assumption that you are using minikube, we have included a script called `build-fio.sh` which will make use of the `Dockerfile` contained within this folder, build it, and make it available to minikube.

### Building FIO
``` sh
./build-fio.sh
```

### Deploying Kubernetes PVC & Job
``` sh
kubectl apply -f fio-pvc.yaml
kubectl apply -f fio-job.yaml
```

### Check the status of the Job with:
```sh
kubectl get job fio-job
```

Once the Job has completed, you can also check the logs of the pod to see the output of the FIO command:
### First find the pod name and save to an ENV VAR
``` sh
POD_NAME=$(kubectl get pod -l app=fio -o jsonpath='{.items[0].metadata.name}')
```

### Then check the logs
``` sh
kubectl logs $POD_NAME
```
After a successful run, you should see something like this:
``` sh
randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.36-11-g95f4
Starting 4 processes
randwrite: Laying out IO file (1 file / 1024MiB)
randwrite: Laying out IO file (1 file / 1024MiB)
randwrite: Laying out IO file (1 file / 1024MiB)
randwrite: Laying out IO file (1 file / 1024MiB)

randwrite: (groupid=0, jobs=4): err= 0: pid=18: Thu Nov  2 10:52:04 2023
  write: IOPS=9854, BW=38.5MiB/s (40.4MB/s)(2313MiB/60083msec); 0 zone resets
    slat (usec): min=4, max=61469, avg=13.51, stdev=172.95
    clat (nsec): min=875, max=750521k, avg=6480147.94, stdev=29106143.73
     lat (usec): min=51, max=750529, avg=6493.66, stdev=29106.68
    clat percentiles (usec):
     |  1.00th=[   791],  5.00th=[  1004], 10.00th=[  1156], 20.00th=[  1631],
     | 30.00th=[  2212], 40.00th=[  2474], 50.00th=[  2704], 60.00th=[  3064],
     | 70.00th=[  4015], 80.00th=[  7832], 90.00th=[  9503], 95.00th=[ 12649],
     | 99.00th=[ 36963], 99.50th=[119014], 99.90th=[530580], 99.95th=[583009],
     | 99.99th=[742392]
   bw (  KiB/s): min= 1354, max=97536, per=100.00%, avg=40908.51, stdev=5982.42, samples=462
   iops        : min=  336, max=24384, avg=10226.36, stdev=1495.63, samples=462
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 100=0.01%, 250=0.01%, 500=0.06%, 750=0.68%
  lat (usec)   : 1000=4.08%
  lat (msec)   : 2=19.18%, 4=45.92%, 10=21.85%, 20=5.93%, 50=1.53%
  lat (msec)   : 100=0.22%, 250=0.21%, 500=0.21%, 750=0.14%, 1000=0.01%
  cpu          : usr=0.83%, sys=5.75%, ctx=482258, majf=0, minf=83
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,592103,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
  WRITE: bw=38.5MiB/s (40.4MB/s), 38.5MiB/s-38.5MiB/s (40.4MB/s-40.4MB/s), io=2313MiB (2425MB), run=60083-60083msec
```