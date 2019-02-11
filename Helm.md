# Configuration in Helm

Once you have Helm ready, you can initialize the local CLI and also install Tiller into your Kubernetes cluster in one step
```
# helm init
```

If you have many Kubernetes cluster. Please using ServiceAccount in Kubernetes:
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm init --service-account tiller --upgrade
```
