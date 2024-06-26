if (( ! ${+ASDF_DIR} )); then
  for ASDF_DIR in \
      {/usr/local,/opt/homebrew,/home/linuxbrew/.linuxbrew}/opt/asdf/libexec \
      /opt/asdf-vm \
      ${HOME}/.asdf
  do
    if [[ -e ${ASDF_DIR} ]] break
  done
fi
export ASDF_DIR

if [[ -e ${ASDF_DIR}/asdf.sh ]]; then
  path=(${ASDF_DIR}/bin ${path:#${ASDF_DIR}/bin})
  fpath+=(${ASDF_DIR}/completions(FN))

  # Don't add shims directory to the path if direnv plugin is installed
  local asdf_data=${ASDF_DATA_DIR:-${HOME}/.asdf}
  path=(${asdf_data}/shims ${path:#${asdf_data}/shims})
  unset asdf_data

  source ${ASDF_DIR}/asdf.sh

  # java home support
  if [[ -e ${ASDF_DIR}/plugins/java/set-java-home.zsh ]]; then
    source ${ASDF_DIR}/plugins/java/set-java-home.zsh
  fi
fi

