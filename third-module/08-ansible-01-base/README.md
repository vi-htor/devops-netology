# Tasks

1. `./group_vars/all/examp.yml`
2. `ansible-playbook  -i inventory/test.yml site.yml `
3. `ansible-vault encrypt group_vars/el/examp.yml`
4. `ansible-vault decrypt group_vars/el/examp.yml`
5. `ansible-vault view group_vars/el/examp.yml`
6. `ansible-playbook  -i inventory/prod.yml site.yml --ask-vault-pass`
7. `winrm`
8. `ansible-doc -t connection ssh`
9. `remote_user`