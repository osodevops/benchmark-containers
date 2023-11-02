# Kubernetes Performance Testing by OSO

Welcome to the OSO Kubernetes Performance Testing repository. This resource hub is designed for network and storage performance benchmarking within Kubernetes environments. This repository features two key subdirectories that equip you with the tools to benchmark and analyze the network and storage performance in your cluster effectively:

- [**iperf3**](iperf3/README.md): For network performance benchmarking, brought to you by OSO.
- [**fio**](fio/README.md): For storage performance benchmarking, curated by OSO.

## iperf3

In the [iperf3 subdirectory](iperf3/README.md) holds the necessary tools and YAML configurations to deploy iperf3 as a robust network performance tool within your Kubernetes environment. Whether you need to maintain a continuous Deployment or execute a one-off Job, iperf3 is your solution for:

- Pinpointing and resolving network issues.
- Validating the network performance of Kubernetes nodes.
- Ensuring service level agreements (SLAs) for applications that are network performance-sensitive.

## FIO

The [fio subdirectory](fio/README.md) contains a Dockerfile and Kubernetes Job YAML for deploying the Flexible I/O Tester (fio), a comprehensive storage benchmarking tool provided by OSO. The fio toolkit is essential for:

- Emulating diverse read/write operations.
- Measuring IOPS (Input/Output Operations Per Second) effectively.
- Gaining insight into the latency and throughput of various storage solutions within Kubernetes.

## Why OSO Recommends Performance Testing in Kubernetes

OSO champions performance testing in Kubernetes because:

1. **Dynamic Environments**: Kubernetes clusters are highly dynamic, making regular performance benchmarking a necessity for maintaining expected service levels.
   
2. **Resource Allocation**: Understanding your infrastructure's capabilities ensures efficient resource allocation, as provided by OSO's tools, avoiding wastage or shortfalls.
   
3. **Troubleshooting**: OSO's tools help in identifying and diagnosing performance bottlenecks, crucial for the seamless operation of your applications.
   
4. **Baseline Performance**: Establishing and tracking performance baselines, as facilitated by these tools, is critical for detecting irregularities and assessing the impact of infrastructure changes.

OSO invites you to delve into the subdirectories, utilize the tools, and join us in enhancing these benchmarking resources for Kubernetes.

---

*Note: This README offers an overview. For detailed instructions and tool usage, please consult the individual READMEs within the respective subdirectories.*
