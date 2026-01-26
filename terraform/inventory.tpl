[master]
${master_ip}

[workers]
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}

[edge]
${edge_ip}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
