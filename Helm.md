# Configuration in Helm

Once you have Helm ready, you can initialize the local CLI and also install Tiller into your Kubernetes cluster in one step
```
# helm init
```

Most cloud providers enable a feature called Role-Based Access Control - RBAC for short. If your cloud provider enables this feature, you will need to create a service account for Tiller with the right roles and permissions to access resources. Please using ServiceAccount in Kubernetes:
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm init --service-account tiller --upgrade
```
