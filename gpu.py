# Function to calculate idx
def calculate_idx(blockIdx_x, blockDim_x, threadIdx_x, blockIdx_y, blockDim_y, threadIdx_y, numCols):
    i = blockIdx_x * blockDim_x + threadIdx_x
    j = blockIdx_y * blockDim_y + threadIdx_y
    idx = numCols * j + i
    return idx

# Take user inputs
blockIdx_x = int(input("Enter blockIdx.x: "))
blockDim_x = 32
threadIdx_x = int(input("Enter threadIdx.x: "))
blockIdx_y = int(input("Enter blockIdx.y: "))
blockDim_y = 32
threadIdx_y = int(input("Enter threadIdx.y: "))
numCols = 1000

# Calculate idx
idx = calculate_idx(blockIdx_x, blockDim_x, threadIdx_x, blockIdx_y, blockDim_y, threadIdx_y, numCols)

# Print the result
print(f"The calculated idx is: {idx}")