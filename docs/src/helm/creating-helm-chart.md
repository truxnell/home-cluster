# Creating a helm chart

Read docs at k8s-at-home.

# Template chart to stdin

Outputs the rendered chart, useful to test it as you make changes

```
helm template nginx-php . --values ./values.yaml --debug
```

# Install from local folder

For `nginx-php` chart for example.
```
helm install nginx-php nginx-php/ --values nginx-php/values.yaml
```
