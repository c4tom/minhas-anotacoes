# Check if the current environment is Windows Subsystem for Linux (WSL)
#
# This function determines whether the script is running in a WSL environment
# by examining the kernel release information.
#
# Returns:
#   1 if running in WSL
#   0 if not running in WSL
isWSL() {
  local uname=`uname -r`
  if [[ $uname == *"Microsofst"* ]]; then 
    echo 1
    else
    echo 0
  fi
}

[[ "`isWSL`" = "0" ]] || { return ; }

# Reinstall Bash completion for WSL
#
# This function reinstalls Bash completion specifically for WSL environments.
# It calls the ct_apt_installBashComplete function to perform the installation.
#
# No parameters.
#
# No return value.
wsl_reinstallBashCompletion() {
  ct_apt_installBashComplete
}
