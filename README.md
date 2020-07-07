# mini-threat-lab

# Requirements
## OpenStack
1. Access to an OpenStack cloud
2. Terraform
3. Ansible

## macOS
1. VirtualBox
2. Docker Desktop
3. Vagrant
4. Ansible

## Windows
1. Windows Subsystem for Linux (WSL)
2. Hyper-V
2. Docker Desktop
3. Vagrant
4. Ansible

# Description
## Components
### Host
The host machine that is to run both the virtual machine and docker containers will also act as a router between the various attack containers, the edge security device, and the simulated target environment.
### Attack Services Environment
The attack services environment is a simulated internet that hosts malicious offensive and scanning services, C2 and some simulated internet functions. All attack functions will be modular in the form of docker containers.
### Muli-Purpose Edge Security Device
A single virtual machine is a multi-purpose edge security device:
 - firewall
 - IDS/IDP
 - Proxy
 - network monitoring
 - web-application firewall
Many of these functions will be provided via containers to make things easily deployable in a single virtual machine.
### Simulated Target Environment
All simulated targets are running as docker containers on the host using the edge security device as a gateway to attack services. The targets are permitted no access to the internet, instead only to the simulated internet of the attack services environment.

# Steps
1. Create docker networks for attack services and the simulated target environments.
2. Create Multi-Purpose Edge Security Device as a virtual machine in its own subnets. The virtual machine will require at least three separate interfaces and unique subnets for each:
    1. The attack interface is a simulated WAN (Internet-facing) port and should be configured with a "real" publicly routeable IP address to permit the attack services to function correctly with minimal configuration.
    2. The targets interface is the gateway for all simulated targets to access "the internet" via the edge security device, with all traffic forwarded to and from the attack interface.
    3. The out-of-band interface(s) is/are for the operator to access the edge security device.
3. Create static routes on the host to route traffic from the edge security device to the docker networks. Create separate routes to allow the operator to connect to the edge security device out-of-band from the docker networks.
4. Deploy defensive and monitoring services on edge security device.
5. Deploy targets into simulated target environment.
6. Deploy attack services into attack services environment.
