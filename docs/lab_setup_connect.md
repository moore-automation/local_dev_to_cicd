# Lab Topology - basic setup and connectivity

For this Hands-On Workshop, we will use Cisco dCloud. It provides an environment that we can connect to via VPN and where our devices are running which we will configure in different ways.

**The credentials for connecting to your dCloud Pod via VPN will be provided by your breakout proctor.**

![Topology](assets/topology.png)

Our Topology features two Catalyst 9k VM Devices that have 8 interfaces each that can be configured. SSH is enabled on both and will be used to connect to these devices during our session.

One device represents the development environment where configuration will be deployed to be tested and verified before being applied to the second device, which represents our production environment.

In each Pod an Ubuntu VM is present to host automation components.


## Addressing and Access

Catalyst VM "dev":

- IP: 198.18.138.11
- admin/C1sco12345

Catalyst VM "prod":

- IP: 198.18.138.12
- admin/C1sco12345

Ubuntu VM:

- IP: 198.18.133.101
- root/C1sco12345
- Can be accessed via RDP if needed

Once you are connected to the VPN and after you installed the required tooling, you can try to access one of the Catalyst VMs via SSH like this:

`ssh admin@198.18.138.11`

Enter the password which will take you to the following prompt:

`Cat9kv-01#`

You have successfully connected to our Lab Environment and are ready to go!
Please proceed to the next Step once you are advised by your proctors.
