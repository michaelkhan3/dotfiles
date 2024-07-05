#!/bin/sh

mkdir -p $ZSH_CUSTOM/plugins/kubectl-autocomplete/
kubectl completion zsh > $ZSH_CUSTOM/plugins/kubectl-autocomplete/kubectl-autocomplete.plugin.zsh
