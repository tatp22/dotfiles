#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
TERMINAL=st; export TERMINAL;
XDG_CONFIG_HOME=~/.config/; export XDG_CONFIG_HOME;
XDG_RUNTIME_DIR=/run/user/1000; export XDG_RUNTIME_DIR;
OPENWEATHERMAP_API_KEY=Nope; export OPENWEATHERMAP_API_KEY;
OPENWEATHERMAP_CITY_ID=Nope; export OPENWEATHERMAP_CITY_ID;
PATH=$PATH:~/.scripts/:~/.local/bin; export PATH;
ECCODES_DIR=/usr/local/; export ECCODES_DIR;
