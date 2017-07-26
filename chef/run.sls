{% from "chef/map.jinja" import chef with context %}

chef_client_execute:
  cmd.run:
    - name: {{ chef.client }}
