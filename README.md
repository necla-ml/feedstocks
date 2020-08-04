# Conda Recipe Feedstocks

Conda recipes for distributing 3rd party code base without official packages.

## Build Targets

Replace `{recipe}` with the package name to build in different variants:

```sh
# Build torch cuda target
make {recipe}-cuda
# Build torch cpu target
make {recipe}-cpu
# Build non-torch target
make {recipe}
```

## Supported Recipes

Working from Git repo with CUDA/CPU variants:
- [ml](https://gitlab.com/necla-ml/ml)
- [ml-vision](https://gitlab.com/necla-ml/ml-vision)

Working from Git repo without specific arch:
- [ml-ws](https://gitlab.com/necla-ml/ml-ws)
- [mmcv](https://github.com/open-mmlab/mmcv)
- [mmdetection](https://github.com/open-mmlab/mmdetection)

Missing Dependencies:
- mxnet-gpu: [dcn-rfcn](https://github.com/necla-ml/Deformable-ConvNets-py3)