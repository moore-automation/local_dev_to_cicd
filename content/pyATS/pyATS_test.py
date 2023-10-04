from pyats.topology.loader import load
import sys

# This script takes two arguments
# 1: dev or prod for the device you want to connect to
# 2: Number 1-8 for the interface GigabitEthernet 1/0/1-8 interfaces on the devices
# Example: 
# python3 pyATS_test.py dev 1 
# For Interface GigabitEthernet 1/0/1 on the dev C9k Device

tb = load('testbed.yaml')
try:
    device = sys.argv[1]
    interface_no = sys.argv[2]
except Exception as e:
    print("Parsing of Interface Config failed! Did you specify the Interface Number (0-8)?")
    print(e)
    sys.exit()

interface = f"GigabitEthernet 1/0/{interface_no}"
phrase = "I'm an automated description"
dev = tb.devices[device]

try:
    dev.connect(mit=True)
    p = dev.parse(f'show interfaces {interface}')
    description = p[f'{interface}']['description']
except Exception as e:
    print(e)

if(phrase not in description):
    sys.exit()
else:
    print(f"Interface description test successful: {phrase}")