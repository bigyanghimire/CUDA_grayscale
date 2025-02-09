NVCC=nvcc 

OPENCV_INCLUDEPATH=$(HOME)/software/spackages/linux-rocky8-x86_64/gcc-9.5.0/opencv-4.6.0-rcspwk7ed63t3i7nqchbebfqyhntitka/include/opencv4
OPENCV_LIBPATH=$(HOME)/software/spackages/linux-rocky8-x86_64/gcc-9.5.0/opencv-4.6.0-rcspwk7ed63t3i7nqchbebfqyhntitka/lib

# OPENCV_LIBS=`pkg-config --libs opencv4`
# OPENCV_CFLAGS=`pkg-config --cflags opencv4`
OPENCV_LIBS=-L$(OPENCV_LIBPATH) 
OPENCV_CFLAGS=-I$(OPENCV_INCLUDEPATH)


CUDA_INCLUDEPATH=$(CUDA_HOME)/targets/x86_64-linux/include

NVCC_OPTS=-arch=sm_30 
GCC_OPTS=-std=c++11 -g -O3 -Wall 
CUDA_LD_FLAGS=-L /usr/local/cuda/lib64 -lcuda -lcudart

final: main.o imgray.o
	g++ -o gray main.o im2Gray.o $(CUDA_LD_FLAGS) $(OPENCV_LIBS)

main.o:main.cpp im2Gray.h utils.h 
	g++ -c $(GCC_OPTS) -I $(CUDA_INCLUDEPATH) $(OPENCV_CFLAGS) main.cpp  $(OPENCV_LIBS) 

imgray.o: im2Gray.cu im2Gray.h utils.h
	$(NVCC) -c im2Gray.cu $(NVCC_OPTS)

clean:
	rm *.o gray
