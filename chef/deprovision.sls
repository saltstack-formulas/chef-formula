# This script is to be called from the reactor system
{% set hostname = data['id'] %}

delete_node:
  cmd.cmd.run:
    - tgt: {{ salt['pillar.get']('chef:main_server') }}
    - arg:
      - knife node delete {{ hostname }} -y

delete_client:
  cmd.cmd.run:
    - tgt: {{ salt['pillar.get']('chef:main_server') }}
    - arg:
      - knife client delete {{ hostname }} -y 
