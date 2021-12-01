ENV=build39
CHANNEL?=NECLA-ML
# 10.2, 7.6.5
# CUDA_VER?=11.0
CUDA_VER?=11.3
# CUDNN_VER?=8.2.1
# 110, 8
# CUDA_PT_VER?=110
# CUDNN_PT_VER?=8
CUDA_PT_VER?=113
CUDNN_PT_VER?=8.2.0
CONDA_NVCC_CONSTRAINT=nvcc_linux-64=${CUDA_VER}
CONDA_CUDATOOLKIT_CONSTRAINT=cudatoolkit=${CUDA_VER}
CUDNN_PACKAGE=cudnn
NCCL_PACKAGE=nccl
MAGMA_PACKAGE=magma-cuda${CUDA_PT_VER}

# PYTHON
PY_VER?=3.9

# PYTORCH
PTH_VER?=1.10
PTV_VER?=0.11	
TRT_VER?=8.2.1.8
TORCH_CUDA_ARCH_LIST?='5.2;6.1;7.0;7.5;8.0;8.6+PTX'

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
				PTV_VER=$(PTV_VER) \
				TRT_VER=$(TRT_VER) \
				TORCH_CUDA_ARCH_LIST=$(TORCH_CUDA_ARCH_LIST) \
				CUDA_PT_VER=$(CUDA_PT_VER) \
				CONDA_NVCC_CONSTRAINT="    - $(CONDA_NVCC_CONSTRAINT) # [not osx]" \
				CONDA_CUDATOOLKIT_CONSTRAINT="    - $(CONDA_CUDATOOLKIT_CONSTRAINT) # [not osx]" \
				NCCL_PACKAGE="    - $(NCCL_PACKAGE) # [not osx and not win]" \
				MAGMA_PACKAGE="    - $(MAGMA_PACKAGE) # [not osx and not win]" \
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
				PTV_VER=$(PTV_VER) \
				CONDA_CPUONLY_FEATURE="    - cpuonly # [not osx]" \
				CONDA_CUDATOOLKIT_CONSTRAINT="    - cpuonly # [not osx]" \
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