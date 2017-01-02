# Elixir-Linear-Algebra
Vector and matrix-operations implemented in Elixir. The goal of Elixir-Linear-Algebra (ELA for short) is to provide a complete and consistent set of functions for basic linear algebra operations. Should you want to contribute you are more than welcome to!

## Implementation
The implementation for both vectors and matrices use Elixir lists, which under the hood are linked lists. Because of this accessing individual elements takes linear time.

    
## Vector operations
Addition
``` 
iex> Vector.add([1, 2, 1], [2, 2, 2])
[3, 4, 3]
``` 

Subtraction
``` 
iex> Vector.sub([1, 2, 1], [2, 2, 2])
[-1, 0, -1]
``` 

Multiplication with scalar
``` 
iex> Vector.scalar([2, 2, 2], 2)
[4, 4, 4]
``` 

Dot product
``` 
iex> Vector.dot([1, 2, 1], [2, 2, 2])
8
``` 

Cross product
``` 
iex> Vector.cross([1, 2, 1], [2, 2, 2])
[2, 0, -2]
``` 

Transpose
``` 
iex> Vector.transp([1, 1, 1])
[[1],
 [1],
 [1]]
``` 

## Matrix operations
Creation
``` 
iex> Matrix.new(3, 2)
[[0, 0],
 [0, 0],
 [0, 0]]
``` 

Identity matrix
``` 
iex> Matrix.identity(3)
[[1, 0, 0],
 [0, 1, 0],
 [0, 0, 1]]
``` 
 
Addition
``` 
iex> Matrix.add([[1, 2, 3],
                 [1, 1, 1]],
                [[1, 2, 2],
                 [1, 2, 1]])
[[2, 4, 5],
 [2, 3, 2]]
``` 

Subtraction
``` 
iex> Matrix.sub([[1, 2, 3],
                 [1, 2, 2]],
                [[1, 2, 3],
                 [2, 2, 2]])
[[0, 0, 0],
 [-1, 0, 0]]
``` 

Multiplication with scalar
``` 
iex> Matrix.scalar([[2, 2, 2],
                    [1, 1, 1]], 2)
[[4, 4, 4],
 [2, 2, 2]]
``` 

Multiplication with vector
``` 
iex> Matrix.mult([1, 1], [[1, 0, 1],
                          [1, 1, 1]])
[[2, 1, 2]]
iex> Matrix.mult([[1, 0, 1],
                  [1, 1, 1]],
                 [[1],
                  [1],
                  [1]])
[[2],
 [3]]
```

Multiplication with matrix
``` 
iex> Matrix.mult([[1, 2],
                  [1, 1]],
                 [[1, 2],
                  [0, 2]])
[[1, 6],
 [1, 4]]
``` 

Transpose
``` 
iex> Matrix.transp([[1, 2, 3],
                    [4, 5, 6]])
[[1, 4],
 [2, 5],
 [3, 6]]
```

Pivoting
```
iex> Matrix.pivot([[2.0, 3.0],
                   [2.0, 3.0],
                   [3.0, 6.0]], 1, 0)
[[0.0, 0.0],
 [1.0, 1.5],
 [0.0, 1.5]]
```

Reduced row echelon form
```
iex> Matrix.reduce([[1.0, 1.0, 2.0, 1.0],
                    [2.0, 1.0, 6.0, 4.0],
                    [1.0, 2.0, 2.0, 3.0]])
[[1.0, 0.0, 0.0, -5.0],
 [0.0, 1.0, 0.0, 2.0],
 [0.0, 0.0, 1.0, 2.0]]
```
