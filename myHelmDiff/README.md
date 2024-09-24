# Helm diff with local repo

## Install the chart:
1. helm package ./kube/my-app
2. helm upgrade --install my-app ./my-app-0.1.0.tgz

## Use custom helm diff:
`./myHelmDiff.sh my-app ./kube/my-app "-f ./kube/my-app/values.yaml -f ./kube/my-app/values.dev.yaml"`


# Helm diff with remote repo

## Install remote repo:
1. helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
2. helm repo update
3. install nginx:
```
helm upgrade --install ingress-nginx-test ingress-nginx \
--repo https://kubernetes.github.io/ingress-nginx \
--namespace ingress-nginx-test --create-namespace \
-f ./kube/ingress/helm-values-test.yaml
```

## Use custom helm diff:
`./myHelmDiffRepo.sh ingress-nginx-test ingress-nginx https://kubernetes.github.io/ingress-nginx ingress-nginx-test "-f ./kube/ingress/helm-values-test.yaml"`

## Test the app via ingress:
1. kubectl apply -f ./kube/ingress/test-ingress.yaml
2. app is available on localhost:30080