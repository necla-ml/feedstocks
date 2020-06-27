ENV?=build37
channel?=NECLA-ML

.PHONY: all

## Conda Distribution

build-dep:
	conda install -y conda-build anaconda-client

%:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$@; conda-build --user $(channel) recipes/$@; \
		conda deactivate

## Conda Environment

conda-install:
	wget -O $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	sh $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh -b -p $(HOME)/miniconda3
	rm -fr $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh

conda-env:
	conda create -n $(ENV) python=3.7

conda-setup:
	echo '' >> $(HOME)/.bashrc
	echo eval \"'$$('$(HOME)/miniconda3/bin/conda shell.bash hook')'\" >> $(HOME)/.bashrc
	echo conda activate $(ENV) >> $(HOME)/.bashrc
	echo '' >> $(HOME)/.bashrc
	echo export EDITOR=vim >> $(HOME)/.bashrc
	echo export PYTHONDONTWRITEBYTECODE=1 >> $(HOME)/.bashrc