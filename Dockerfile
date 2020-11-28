from ubuntu:18.04

env DEBIAN_FRONTEND=noninteractive

arg USER
arg UID
arg GID

run test -n "$USER"
run test -n "$UID"
run test -n "$GID"

run apt update
run apt install -y r-base wget libxml2
run wget https://download2.rstudio.org/server/xenial/amd64/rstudio-server-1.3.1093-amd64.deb
run apt install -y psmisc sudo lsb-release libclang-dev
run apt install -y libssl1.0.0
run dpkg -i rstudio-server-1.3.1093-amd64.deb

run echo "auth-minimum-user-id=$UID" >> /etc/rstudio/rserver.conf
run useradd $USER -u $UID -g $GID -m
run echo "$USER:rstudio" | chpasswd

run Rscript -e "install.packages(\"devtools\")"
run Rscript -e "install.packages(\"tensorflow\")"
run Rscript -e "install.packages(\"tidyverse\")"
run Rscript -e "install.packages(\"rmarkdown\")"
run Rscript -e "devtools::install_github(\"jonathanbratt/RBERT\")"
run Rscript -e "devtools::install_github(\"jonathanbratt/RBERTviz\")"
run Rscript -e "devtools::install_github(\"rstudio/reticulate\")"

user $USER

run Rscript -e "reticulate::install_miniconda()"
run Rscript -e "tensorflow::install_tensorflow(version=\"1.12\")"

user root

entrypoint /usr/lib/rstudio-server/bin/rserver --server-daemonize 0
