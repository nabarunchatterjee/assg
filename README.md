# Problem
Write code in Python or Terraform to


1. Create a load balancer

2. Deploy an auto scaling group with 5 VMs with

    - web server (say Apache) installed

    - has index.html

    - (optional) PHP page that returns "Hello World <hostname>"

3. Setup a health check for checking each instance to return valid data for ```GET /index.html``` on port 80


Make sure that the load balancer can automatically replace VMs, when


1. there aren't enough VMs. Simulate this by killing a VM attached to lb.

2. a VM goes unhealthy. Simulate this by killing apache server in the VM (or deleting index.html, thus returning a non 200 code)


# Solution

Disclaimer: The solution in this repo just solves the above question and is not a proper production setup.

# TODO
* Better Documentation
* Better Networking
* More use of variables to make solution more generic
