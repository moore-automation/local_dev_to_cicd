# Loading your toolbelt

Now, you might want to get you hands less dirty than using th CLI manually every time you make a change to one device. Or what do you do when you need to make changes to multiple devices?
There are plenty of tools that can help you work with your devices and automate some simple workflows already.

## Install Tools
We have prepared a set of tools that you can use by cloning the repository and starting you own environment in docker using compose.

This project is extremely simple, it requires only docker to be installed on the host and this repository to be cloned or manually copied. *default today is compose version 2*

**You might have to change the `EXT_IMG_VERSION_GITLAB` variable in the `.env` file in this repository, depending on what's your processors architecture!**

1. To start the service simply run either of the following:
   1. (Version 1) ```docker-compose up -d```
   2. (Version 2+) ```docker compose up -d```
2. Check containers are spinning up
3. Go have a cup of tea for 5 minutes while gitlab get's ready.
4. Access gitlab in your browser : http://localhost:2080
5. Access devtools from cli : ```docker exec -it engine_devtools bash```

Should look something like this:

![docker_startup](../assets/run.gif)

Once all the containers are up and running, you  got yourself a great automation toolset and a GitLab instance of your own! All inclusive a GitLab runner that will take care of the execution of our pipeline later on.

## Netmiko

One example of the tools that can be used is [Netmiko](https://github.com/ktbyers/netmiko). 

We will make a short example here on how to use Netmiko to configure our interface using a python script.
For this, you can use the devtools provided to you. After you accessed the devtools from cli like shown in step 5 above, you are ready to go.

If you want to do it locally, will you need to have Python installed and to install netmiko, simply use pip: `$ pip install netmiko`

We will use the following small python script, which is also located on the devtools container:
```python
    from netmiko import ConnectHandler

    cat_dev = {
        'device_type': 'cisco_xe',
        'host':   '198.18.138.11',
        'username': 'admin',
        'password': 'C1sco12345',
    }
    net_connect = ConnectHandler(**cat_dev)
    # Execute Show Command
    output = net_connect.send_command('show run | section interface')
    print(output)
    print("\n")
    config_commands = [ 'interface GigabitEthernet 1/0/1',
                        'description Configured with netmiko by frewagne'
                    ]
    # Use your assigned interface to configure!
    output = net_connect.send_config_set(config_commands)
    print(output)
    print("\n")
    output = net_connect.send_command('show run | section interface')
    print(output)
```

Execute the python script using `$ python3 netmiko_interface_description.py`

Once the script has been successfully executed, we can check the current interface config:
```
    Cat9kv-01#sh run | section interface
    interface GigabitEthernet0/0
      vrf forwarding Mgmt-vrf
      ip dhcp client client-id GigabitEthernet0/0
      ip address dhcp
      negotiation auto
    interface GigabitEthernet1/0/1
      description Configured with netmiko by frewagne
    interface GigabitEthernet1/0/2
    interface GigabitEthernet1/0/3
    ...
```