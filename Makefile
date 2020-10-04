ENV=build37
CHANNEL?=NECLA-ML
CONDA_CUDATOOLKIT_CONSTRAINT="cudatoolkit=10.2"
MAGMA_PACKAGE=magma-cuda102

.PHONY: all

## Conda Distribution

build-dep:
	conda install -y conda-build anaconda-client -n $(ENV)

%-cuda:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$*; \
			export CONDA_CPUONLY_FEATURE=""; \
			CONDA_CUDATOOLKIT_CONSTRAINT='    - $(CONDA_CUDATOOLKIT_CONSTRAINT) # [not osx]' \
			MAGMA_PACKAGE="    - $(MAGMA_PACKAGE) # [not osx and not win]" \
			BLD_STR_SUFFIX="" \
			GIT_LFS_SKIP_SMUDGE=1 \
			conda-build --user $(CHANNEL) recipes/$*; \
		conda deactivate

%-cpu:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$*; \
			export CONDA_CPUONLY_FEATURE="    - cpuonly # [not osx]"; \
			CONDA_CUDATOOLKIT_CONSTRAINT="    - cpuonly # [not osx]" \
			MAGMA_PACKAGE="" \
			BLD_STR_SUFFIX="_cpu" \
			GIT_LFS_SKIP_SMUDGE=1 \
			conda-build --user $(CHANNEL) recipes/$*; \
		conda deactivate

%:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$@; \
			BLD_STR_SUFFIX="" \
			GIT_LFS_SKIP_SMUDGE=1 \
			conda-build --user $(CHANNEL) recipes/$@; \
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