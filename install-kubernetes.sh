curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.15.5/bin/darwin/amd64/kubectl" && \
  chmod +x ./kubectl && \
  sudo mv ./kubectl /usr/local/bin/kubectl && \
  kubectl version

# add credentials
#yc managed-kubernetes cluster get-credentials testcluster --external
