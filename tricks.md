#Shell completion for zsh:
Add `source <(kubectl completion zsh)` to `~/.zshrc` file.
https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion

#kubectx + kubens
`brew install kubectx`
https://github.com/ahmetb/kubectx

#telepresence
`brew cask install osxfuse`
`brew install datawire/blackbird/telepresence`

#skaffold
`brew install skaffold`

# jq command:
`brew install jq`

#add yandex credentials to config
`yc managed-kubernetes cluster get-credentials cluster-name --external`

#letsencrypt with dns challenge
sudo certbot -d <domain name> --manual --preferred-challenges dns certonly
