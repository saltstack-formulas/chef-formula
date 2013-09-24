# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden via Pillar.
{% from "chef/map.jinja" import chef with context %}

# Put the ``client.rb`` file in place
chef_confdir:
  file:
    - directory
    - name: {{ chef.confdir }}

chef_config:
  file:
    - managed
    - name: {{ chef.confdir }}/client.rb
    - contents_pillar: 'chef:client.rb'
    - require:
      - file: chef_confdir

chef_validator:
  file:
    - managed
    - name: {{ chef.confdir }}/validation.pem
    - contents_pillar: 'chef:validation_pem'
    - require:
      - file: chef_confdir

# Download and execute the Chef bootstrap bash script
curl:
  pkg:
    - installed

bootstrap_chef:
  cmd:
    - run
    - name: curl -L https://www.opscode.com/chef/install.sh | bash
    - stateful: True
    - require:
      - pkg: curl

# Do the initial Chef client run
initial_chef_run:
  cmd:
    - run
    - name: chef-client
    - require:
      - cmd: bootstrap_chef
      - file: chef_config

# Remove the validation.pem file if the inital run successfully produced
# ``client.pem``
chef_client_pem:
  file:
    - exists
    - name: {{ chef.confdir }}/client.pem
    - require:
      - cmd: initial_chef_run

chef_validator_rm:
  file:
    - absent
    - name: {{ chef.confdir }}/validation.pem
    - require:
      - file: chef_client_pem
