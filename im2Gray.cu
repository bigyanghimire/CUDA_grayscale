#include "im2Gray.h"

#define BLOCK 32

/*

  Given an input image d_in, perform the grayscale operation
  using the luminance formula i.e.
  o[i] = 0.224f*r + 0.587f*g + 0.111*b;

  Your kernel needs to check for boundary conditions
  and write the output pixels in gray scale format.

  you may vary the BLOCK parameter.

 */
__global__ void im2Gray(uchar4 *d_in, unsigned char *d_grey, int numRows, int numCols)
{

  /*
    Your kernel here: Make sure to check for boundary conditions
   */

  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  int idx = numCols * j + i;

  if (idx < numCols * numRows)
  {

    uchar4 pixel = d_in[idx];
    float r = (float)pixel.x;
    float g = (float)pixel.y;
    float b = (float)pixel.z;
    // d_grey[idx] = (unsigned char)23;
    float gray_s = 0.224f * r + 0.587f * g + 0.111 * b;
    d_grey[idx] = (unsigned char)roundf(gray_s);
  }
}

void launch_im2gray(uchar4 *d_in, unsigned char *d_grey, size_t numRows, size_t numCols)
{
  // configure launch params here
  printf("rows are %d and cols are %d ok\n", numRows, numCols);
  dim3 grid((numCols + 31) / 32, (numRows + 31) / 32, 1);
  dim3 block(32, 32, 1);

  im2Gray<<<grid, block>>>(d_in, d_grey, numRows, numCols);
  cudaDeviceSynchronize();
  checkCudaErrors(cudaGetLastError());
}
