# benchmark-containers
Benchmark container build files for a variety of cloud-native benchmarks.

## Fio container
The FIO container ships release 3.36 of the Flexible IO tester.
```shell
$ docker build -t fio .
$ docker run -it fio /bin/sh

# Test sequential write bandwidth
fio --name TEST --eta-newline=5s --filename=temp.file --rw=write --size=2g --io_size=10g --blocksize=1024k --ioengine=libaio --fsync=10000 --iodepth=32 --direct=1 --numjobs=1 --runtime=60 --group_reporting

# Test sequential read bandwidth
fio --name TEST --eta-newline=5s --filename=temp.file --rw=read --size=2g --io_size=10g --blocksize=1024k --ioengine=libaio --fsync=10000 --iodepth=32 --direct=1 --numjobs=1 --runtime=60 --group_reporting


# Test random read bandwidth & iops
fio --name TEST --eta-newline=5s --filename=temp.file --rw=randread --size=2g --io_size=10g --blocksize=4k --ioengine=libaio --fsync=1 --iodepth=1 --direct=1 --numjobs=32 --runtime=60 --group_reporting
```

## ipref3
Testing Network capability
```shell
$ docker build -t iperf .
$ docker run -it ipref /bin/sh

# Do a network test to check what bandwidth looks like via iperf3 - this will give you an indication of the maximum network throughput between the client machine and the brokers.

# Server: 
$ iperf3 -s -p 3002 -f m

#Client: 
$ iperf3 -c localhost -p 3002 -t 60
```