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

Working from Git repo:
- [ml-ws](https://gitlab.com/necla-ml/ml-ws)

Working from PYPI source:
- [mmcv](https://github.com/open-mmlab/mmcv)

Stuck on Git Repo and no PYPI source:
- [mmdetection](https://github.com/open-mmlab/mmdetection)

Missing Dependencies:
- mxnet-gpu: [dcn-rfcn](https://github.com/necla-ml/Deformable-ConvNets-py3)
