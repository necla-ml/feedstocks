VERSION=4.5.3.56

# download whl 
wget -O opencv_python-$VERSION-cp39-cp39-manylinux2014_x86_64.whl \
    https://files.pythonhosted.org/packages/6d/7c/acb51d4af0239979a5faf8542a58f8d5774cc30f6a2384527bffbb29278e/opencv_python-$VERSION-cp39-cp39-manylinux2014_x86_64.whl
    
# pip install
pip install opencv_python-$VERSION-cp39-cp39-manylinux2014_x86_64.whl --no-deps --ignore-installed -vvv