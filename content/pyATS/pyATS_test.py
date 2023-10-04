from pyats.topology.loader import load
import sys

tb = load('testbed.yaml')
try:
    interface_no = sys.argv[1]
except Exception as e:
    print("Parsing of Interface Config failed! Did you specify the Interface Number (0-8)?")
    print(e)
    sys.exit()

interface = f"GigabitEthernet 1/0/{interface_no}"
phrase = "I'm an automated description"
dev = tb.devices['dev']

try:
    dev.connect(mit=True)
    p = dev.parse(f'show interfaces {interface}')
    description = p[f'{interface}']['description']
except Exception as e:
    print(e)

if(phrase not in description):
    sys.exit()
else:
    print("Interface description test successful: ")