#!/bin/bash
shuf -r -n 50000 << 'WORDS' > /tmp/chunk.txt
apache spark distributed computing framework processes big data across clusters
machine learning algorithms analyze patterns in massive datasets efficiently
python java scala programming languages support functional reactive paradigms
cloud infrastructure scales horizontally using containerized microservices architecture
network protocols transmit packets through routers switches and firewalls securely
database systems optimize queries using indexes caching and query planning
artificial intelligence models train on gpus using backpropagation gradient descent
distributed systems handle failures through replication consensus and partitioning
web applications render components using javascript frameworks and virtual dom
data pipelines transform extract load information between heterogeneous sources
software engineering practices include testing debugging profiling and monitoring
cybersecurity measures protect networks from intrusions malware and vulnerabilities
operating systems manage processes memory filesystems and device drivers
algorithms solve problems using divide conquer dynamic programming greedy approaches
compilers translate source code into executable machine instructions optimized
WORDS

for i in {1..10240}; do cat /tmp/chunk.txt; done > test_10gb.txt
rm /tmp/chunk.txt