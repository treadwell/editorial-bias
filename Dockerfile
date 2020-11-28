from rocker/rstudio

env DEBIAN_FRONTEND=noninteractive

run apt update
run apt install -y libxml2
run Rscript -e "install.packages(\"devtools\")"
run Rscript -e "install.packages(\"tensorflow\")"
run Rscript -e "install.packages(\"tidyverse\")"
run Rscript -e "install.packages(\"rmarkdown\")"
run Rscript -e "devtools::install_github(\"jonathanbratt/RBERT\")"
run Rscript -e "devtools::install_github(\"jonathanbratt/RBERTviz\")"
run Rscript -e "devtools::install_github(\"rstudio/reticulate\")"

run su rstudio -c 'Rscript -e "reticulate::install_miniconda()"'
run su rstudio -c 'Rscript -e "tensorflow::install_tensorflow(version=\"1.12\")"'
