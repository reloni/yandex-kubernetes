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


gitlab-runner-token-r7dbz

eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJ0ZXN0LW5zIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImdpdGxhYi1ydW5uZXItdG9rZW4tcjdkYnoiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZ2l0bGFiLXJ1bm5lciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjkzMzczMjZkLTBiMWMtNDQ3Yy1hNmY3LTdjNDU5MmYxNTY4NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDp0ZXN0LW5zOmdpdGxhYi1ydW5uZXIifQ.PXajkgUotQuPSp_TimD9rSM5jLOArOM9HZftwP976gBHoqOzsdGELrUPnnyEbOT8dHYhfKYr4icequ61uqNUTerW19K1xQ94c870ntRG8wiGCqT-WUwrcjL9FQbnaImph5Lsi9wl801NLondtxz_wfiBVLhifydTzigEssDpJyTby7L_FlALGigpod0TSaoCM6epk2CyPR5g5wJd09LXXo_ez_pi-KSuNRqNDJCgpM9ZM3o2zejvH9AQOMHm8xR08VhU_ALcJhYCHpzzIFArJJ7WD5sc1P9Iv1Ld4WXFwS4WmZaX52O3uL80LidkMPx3zxzCj8zRF5HydYcNa9nvEg

-----BEGIN CERTIFICATE-----
MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTE5MTIzMDE4MTI0NFoXDTI5MTIyNzE4MTI0NFowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALel
C9KaSH9miVEcm4iwlqCVbz2rxLgZ8O0oIxQ38TAWmOytdnmJTpiyxgWVuh6TU04O
2CdAUKuwifPwzLAjHOzu3sx2aCvyvF1i938OAgvdfBeuA3MbogBzB6lXW7Vaw3P8
BK8rIvkuV0FSd8mtG1XyOxeKZB8aQddEqJLmxFAbB6sr5V0iFD8eJOyG4xbF2Ad7
MXzd/XrjM1F5QZpfxQoax/AGeryjJsfWkRsDaX43VCYA6DJHpnKZumHm5nTSTsWf
Cs2wUYr9Eu4ZYXLdv50pdYOIw3mWEdtj4X5O+Jwx5vKzNFocbv5aabbksrFMVt4A
Iz5UCasGnywRR51dUSsCAwEAAaMjMCEwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAItp3X3A/g5NnA0XE494uAmtgvYL
3DgHMkkIYjvO20fjOzrHAyV7oxWd5NdLaaeefH1ykj81ko82oXzz+vcRT94/4xkA
h1kotjduEKDUk8W/GTK+w7A9nOs+xjWN9yBeOTS/tIaNhU7j2ZT0RTwlSZMCbHap
3hSpzb/XZJPDgsOHSgoX6QDdO55KmnZOven08IKFhv1NNJCT3Xi6mTMLGtJs13fK
v2brBJlkhMGnYkABPIA8K46QMsUxauwGzZCGmc507f+xqIWOPybaNq5u5+5+Fft7
l7xw5cb4Hx1DB4/K2dliQSEgxqWk6ivB9adzKPdPSGq62e+P7tIjdqm8Plo=
-----END CERTIFICATE-----
