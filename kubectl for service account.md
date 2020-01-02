create service account
`kubectl create serviceaccount gitlab-runner`
`kubectl create clusterrolebinding gitlab-runner --clusterrole cluster-admin --serviceaccount test-ns:gitlab-runner`

get account secret name
`kubectl get sa gitlab-runner -o jsonpath='{.secrets[0].name}'`

decode secret value (token)
`kubectl get secret gitlab-runner-token-r7dbz -o jsonpath='{.data.token}'|base64 --decode`

certificate
`kubectl get secret gitlab-runner-token-r7dbz -o jsonpath='{.data.ca\.crt}'|base64 --decode`

save cert
`kubectl get secret gitlab-runner-token-r7dbz -o jsonpath='{.data.ca\.crt}'|base64 --decode > gitlab-runner.crt`

setup config
`kubectl config set-cluster yandex-cluster --server=https://84.201.180.145 --certificate-authority=/usr/local/etc/gitlab-runner.crt --embed-certs=true`
`kubectl config set-credentials gitlab-runner --token=<token>`
`kubectl config set-context k8s --cluster yandex-cluster --user gitlab-runner`
`kubectl config use-context k8s`
