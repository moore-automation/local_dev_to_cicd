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