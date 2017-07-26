{% from "chef/map.jinja" import chef with context %}
{% set client_rb = salt['pillar.get']('chef:client_rb') %}
{% set validation_pem = salt['pillar.get']('chef:validation_pem') %}

/etc/chef:
  file.directory:
    - user: root
    - group: root
    - makedirs: True

/etc/chef/client.rb:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - template: jinja
    - source: salt://chef/templates/client_rb.sls
    - context:
        config: {{ client_rb }}
    - require:
        - file: /etc/chef

/etc/chef/validation.pem:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - contents: |
        {{ validation_pem | indent(8) }}
    - require:
        - file: /etc/chef

curl:
  pkg.installed: []

install_chef:
  cmd.run:
    - name: {{ chef.bootstrap_command }}
    - unless: which {{ chef.client }}
    - require:
        - pkg: curl
