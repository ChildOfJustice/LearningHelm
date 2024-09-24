# Install the chart:

helm package ./kube/my-app
helm upgrade --install my-app ./my-app-0.1.0.tgz

# Use custom helm diff:
./myHelmDiff.sh my-app ./kube/my-app "-f ./kube/my-app/values.yaml -f ./kube/my-app/values.dev.yaml"