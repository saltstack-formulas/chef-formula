{% from "chef/map.jinja" import chef with context %}

{{ chef.config_file }}:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - template: jinja
    - source: salt://chef/templates/client_rb.jinja
    - context:
        client_rb: {{ salt['pillar.get']('chef:client_rb') }}
    - makedirs: True
    - dir_mode: 0644

{{ chef.validation_file }}:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - contents: |
        {{ salt['pillar.get']('chef:validation_pem') | indent(8) }}
    - makedirs: True
    - dir_mode: 0644
