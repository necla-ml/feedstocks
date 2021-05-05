ENV?=build37
CHANNEL?=NECLA-ML
# 10.2, 7.6.5
CUDA_VER?=11.0
CUDNN_VER?=8.0.5
# 110, 8
CUDA_PT_VER?=110
CUDNN_PT_VER?=8
CONDA_NVCC_CONSTRAINT=nvcc_linux-64=${CUDA_VER}
CONDA_CUDATOOLKIT_CONSTRAINT=cudatoolkit=${CUDA_VER}
CUDNN_PACKAGE=cudnn
MAGMA_PACKAGE=magma-cuda${CUDA_PT_VER}

# PYTORCH
PTH_VER?=1.7.0
TORCH_CUDA_ARCH_LIST?='5.2;6.1;7.0;7.5'

.PHONY: all

## Conda Distribution

build-dep:
	conda install -y conda-build anaconda-client -n $(ENV)

%-cuda:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			RECIPE=$* \
			CONDA_CPUONLY_FEATURE="" \
			PTH_VER=$(PTH_VER) \
			TORCH_CUDA_ARCH_LIST=$(TORCH_CUDA_ARCH_LIST) \
			CUDA_PT_VER=$(CUDA_PT_VER) \
			CONDA_NVCC_CONSTRAINT='    - $(CONDA_NVCC_CONSTRAINT) # [not osx]' \
			CONDA_CUDATOOLKIT_CONSTRAINT='    - $(CONDA_CUDATOOLKIT_CONSTRAINT) # [not osx]' \
			MAGMA_PACKAGE="    - $(MAGMA_PACKAGE) # [not osx and not win]" \
			BLD_STR_SUFFIX="_cuda$(CUDA_PT_VER)_cudnn$(CUDNN_PT_VER)" \
			GIT_LFS_SKIP_SMUDGE=1 \
			conda-build --user $(CHANNEL) recipes/$*; \
		conda deactivate

%-cpu:
	eval "`$$HOME/miniconda3/bin/conda shell.bash hook`"; \
		conda activate $(ENV); \
			conda config --set anaconda_upload yes; \
			conda-build purge-all; \
			RECIPE=$* \
			PTH_VER=$(PTH_VER) \
			CONDA_CPUONLY_FEATURE="    - cpuonly # [not osx]" \
			CONDA_CUDATOOLKIT_CONSTRAINT="    - cpuonly # [not osx]" \
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