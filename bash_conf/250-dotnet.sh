[[ -f $(type -p dotnet) ]] || { return ; }

export DOTNET_ROOT=/desenv/dotnet
export PATH=$PATH:/desenv/dotnet