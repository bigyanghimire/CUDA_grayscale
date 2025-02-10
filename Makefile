NVCC = nvcc

# Use pkg-config for OpenCV paths
OPENCV_LIBS := $(shell pkg-config --libs opencv4)
OPENCV_CFLAGS := $(shell pkg-config --cflags opencv4)

CUDA_HOME = /usr/local/cuda
CUDA_INCLUDEPATH = $(CUDA_HOME)/targets/x86_64-linux/include

NVCC_OPTS =
GCC_OPTS = -std=c++11 -g -O3 -Wall
CUDA_LD_FLAGS = -L /usr/local/cuda/lib64 -lcuda -lcudart

final: main.o imgray.o
	g++ -o gray main.o im2Gray.o $(CUDA_LD_FLAGS) $(OPENCV_LIBS)

main.o: main.cpp im2Gray.h utils.h
	g++ -c $(GCC_OPTS) -I$(CUDA_INCLUDEPATH) $(OPENCV_CFLAGS) main.cpp 

imgray.o: im2Gray.cu im2Gray.h utils.h
	$(NVCC) -c im2Gray.cu $(NVCC_OPTS) -I$(CUDA_INCLUDEPATH) $(OPENCV_CFLAGS)

clean:
	rm -f *.o gray



# export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH