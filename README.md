# Vagrant VirtualBox
Create k8s multinode cluster with vagrant, virtualbox and ansible

## Required Software
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Ansible 2.x](https://docs.ansible.com/ansible/2.8/installation_guide/intro_installation.html)
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) 

## Steps
### To create cluster 

1. update `config.json` file
    - To set config of each node
        ```
        {
            "memory": "2048",
            "cpu": "2",
            "ip": "10.0.0.10"
        }
      ```
    - Common for every node 
        ```
        {
            "vbox_image": "ubuntu/xenial64",
            "pod_network_cidr": "10.244.0.0/16",
            "kubernetes_version": "1.14.5-00"
        }
        ```
        
2. Run command
    ``` 
    vagrant up 
    ```

### To access k8s cluster
- MacOS and Linux
  ```
  export KUBECONFIG=<path_to_this_dir>/credentials/kube-config
  ```

### To destroy cluster 
```
vagrant destroy -f
```