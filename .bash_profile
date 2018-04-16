echo "This is bash_profile. "

export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:/usr/local/bin
export MANPATH=/usr/local/share/man:$MANPATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH="/usr/local/bin:$PATH"
export HOMEBREW_GITHUB_API_TOKEN="122c4c660d3c70ce30fe82a1bfb7378d801c342f"

test -r ~/.bashrc && . ~/.bashrc
export PATH="/usr/local/opt/qt/bin:$PATH"
