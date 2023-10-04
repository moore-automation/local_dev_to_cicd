# Loading your toolbelt

Now, you might want to get you hands less dirty than using th CLI manually every time you make a change to one device. Or what do you do when you need to make changes to multiple devices?
There are plenty of tools that can help you work with your devices and automate some simple workflows already.
One example of this is [Netmiko](https://github.com/ktbyers/netmiko). 

We will make a short example here on how to use Netmiko to configure our interface using a python script.
For this, you will need Python installed on your machine, but you can also follow the demo in the session.
To install netmiko, simply use pip: `$ pip install netmiko`

We will use the following small python script:
```python
    from netmiko import ConnectHandler

    cat_dev = {
        'device_type': 'cisco_xe',
        'host':   '198.18.132.151',
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