# All Hands on Deck
Now, we will start to make our first changes to our config and build the foundation for our CI/CD pipline that we will create later.

## Manual Labour
First, go ahead and make a manual change to the configuration of the interface that has been assigned to you.

For this, you can connect to the **dev** Switch on 198.18.132.151 via SSH. 
You will find yourself on the command line with the enabled prompt **`#`**

Your first task is to go into the configuration mode and change the description of your assigned interface. Maybe you could mark it with your name?

If you have trouble doing this on your own you can find the solution down below.
<details>

<summary>Click here to show solution</summary>
  
  ```bash linenums="1" title="Manual Configuration Example"
      Cat9kv-01#

      # Let's check the current interface config

      Cat9kv-01#sh run | section interface
      interface GigabitEthernet0/0
        vrf forwarding Mgmt-vrf
        ip dhcp client client-id GigabitEthernet0/0
        ip address dhcp
        negotiation auto
      interface GigabitEthernet1/0/1
      interface GigabitEthernet1/0/2
      interface GigabitEthernet1/0/3
      ...

      Cat9kv-01#
      Cat9kv-01#conf t
      Cat9kv-01(config)#interface GigabitEthernet 1/0/1 
      Cat9kv-01(config-if)#description Configured manually by frewagne
      Cat9kv-01(config-if)#end

      # Now check the config of the interfaces again

      Cat9kv-01#sh run | section interface
      interface GigabitEthernet0/0
        vrf forwarding Mgmt-vrf
        ip dhcp client client-id GigabitEthernet0/0
        ip address dhcp
        negotiation auto
      interface GigabitEthernet1/0/1
        description Configured manually by frewagne
      interface GigabitEthernet1/0/2
      interface GigabitEthernet1/0/3
      ...
  ```

</details>
