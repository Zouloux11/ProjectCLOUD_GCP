[master]
spark-master ansible_host=${master_ip}

[workers]
%{ for idx, ip in worker_ips ~}
spark-worker${idx + 1} ansible_host=${ip}
%{ endfor ~}

[edge]
spark-edge ansible_host=${edge_ip}

[all:vars]
ansible_user=${ssh_user}
ansible_ssh_private_key_file=${ssh_key}
ansible_python_interpreter=/usr/bin/python3