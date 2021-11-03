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

# Install using git if not already installed at ASDF_DIR
if [[ ! -e ${ASDF_DIR} ]]; then
  print -u2 -R "${ASDF_DIR} not found, installing asdf"
  command git clone -q https://github.com/asdf-vm/asdf.git ${ASDF_DIR} || return 1
  command git -C ${ASDF_DIR} checkout -q $(command git -C ${ASDF_DIR} describe --abbrev=0 --tags) -- || return 1
fi

path=(${ASDF_DIR}/bin ${path:#${ASDF_DIR}/bin})
fpath+=(${ASDF_DIR}/completions(FN))

source ${ASDF_DIR}/lib/asdf.sh

# java home support
if [[ -e ${ASDF_DIR}/plugins/java/set-java-home.zsh ]]; then
  source ${ASDF_DIR}/plugins/java/set-java-home.zsh
fi	
