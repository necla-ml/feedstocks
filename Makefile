ENV=build39
CHANNEL?=NECLA-ML

# PYTHON
PY_VER?=3.9

# CUDA
CUDA_VER?=11.8
CUDA_PT_VER?=118
CUDNN_PT_VER?=8.7.0
CONDA_NVCC_CONSTRAINT=nvcc_linux-64=${CUDA_VER}
CUDNN_PACKAGE=cudnn
NCCL_PACKAGE=nccl

# PYTORCH
PTH_VER?=2.0.1
PTV_VER?=0.15.2
TRT_VER?=8.6.1
PTH_CUDA=pytorch::pytorch-cuda=${CUDA_VER}

.PHONY: all

## Conda Distribution
build-dep:
	mamba install -y boa anaconda-client -n $(ENV)

# XXX must build in the base env
%-cuda:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda deactivate; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$* \
				CONDA_CPUONLY_FEATURE="" \
				PY_VER=$(PY_VER) \
				PTH_VER=$(PTH_VER) \
				PTH_BUILD=cuda \
				PTV_VER=$(PTV_VER) \
				TRT_VER=$(TRT_VER) \
				PTH_CUDA="    - $(PTH_CUDA) # [not osx]" \
				CUDA_PT_VER=$(CUDA_PT_VER) \
				CONDA_NVCC_CONSTRAINT="    - $(CONDA_NVCC_CONSTRAINT) # [not osx]" \
				NCCL_PACKAGE="    - $(NCCL_PACKAGE) # [not osx and not win]" \
				BLD_STR_SUFFIX="_cuda$(CUDA_PT_VER)_cudnn$(CUDNN_PT_VER)" \
				GIT_LFS_SKIP_SMUDGE=1; \
			conda mambabuild --user $(CHANNEL) recipes/$*; \
		conda deactivate

%-cpu:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda deactivate; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$* \
				PY_VER=$(PY_VER) \
				PTH_VER=$(PTH_VER) \
				PTH_BUILD=cpu \
				PTV_VER=$(PTV_VER) \
				CONDA_CPUONLY_FEATURE="    - cpuonly # [not osx]" \
				BLD_STR_SUFFIX="_cpu" \
				GIT_LFS_SKIP_SMUDGE=1; \
			conda-mambabuild --user $(CHANNEL) recipes/$*; \
		conda deactivate

%:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda deactivate; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			export RECIPE=$@ \
				PY_VER=$(PY_VER) \
				BLD_STR_SUFFIX="" \
				GIT_LFS_SKIP_SMUDGE=1; \
			conda-mambabuild --user $(CHANNEL) recipes/$@; \
		conda deactivate

## Conda Environment

conda-install:
	wget -O $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	sh $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh -b -p $(HOME)/miniconda3
	rm -fr $(HOME)/Downloads/Miniconda3-latest-Linux-x86_64.sh

conda-env:
	mamba create -y -n $(ENV) python=$(PY_VER)

conda-setup:
	echo '' >> $(HOME)/.bashrc
	echo eval \"'$$('$(HOME)/miniconda3/bin/conda shell.bash hook')'\" >> $(HOME)/.bashrc
	echo conda activate $(ENV) >> $(HOME)/.bashrc
	echo '' >> $(HOME)/.bashrc
	echo export EDITOR=vim >> $(HOME)/.bashrc
	echo export PYTHONDONTWRITEBYTECODE=1 >> $(HOME)/.bashrc

conda-pkgs:
	conda install mamba -y -n base -c conda-forge