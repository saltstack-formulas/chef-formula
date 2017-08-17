{% from "chef/map.jinja" import chef with context %}

curl:
  pkg.installed: []

install-chef:
  cmd.run:
    - name: {{ chef.bootstrap_command }}
    - unless: which chef-client
    - require:
        - pkg: curl
