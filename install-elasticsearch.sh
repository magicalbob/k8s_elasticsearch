# create elasticsearch namespace, if it doesn't exist
kubectl get ns elasticsearch 2> /dev/null
if [ $? -eq 1 ]
then
    kubectl create namespace elasticsearch
fi

# sort out physical volume
export NODE_NAME=$(kubectl get nodes | grep -v ^NAME|grep -v control-plane|cut -d\  -f1|head -1)
envsubst < elasticsearch.deploy.pv.template > elasticsearch.deploy.pv.yml
echo mkdir -p ${PWD}/elasticsearch-data|ssh -o StrictHostKeyChecking=no ${NODE_NAME}
kubectl apply -f elasticsearch.deploy.pv.yml

# create elasticsearch  deployment
kubectl apply -f elasticsearch.yml
