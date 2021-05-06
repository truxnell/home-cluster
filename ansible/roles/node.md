

Encrypt a string

```
ansible-vault encrypt_string password123 --ask-vault-pass
```

Paste encrypted output into the YAML manually


Run playbook with `--ask-vault-password`
```
ansible-playbook -i inventory/home/hosts.yml playbooks/k3s/install.yml --ask-vault-password
```
