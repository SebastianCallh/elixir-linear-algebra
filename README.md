# Elixir-Linear-Algebra
Vector and matrix-operations implemented in Elixir. The goal of Elixir-Linear-Algebra (ELA for short) is to provide a complete and consistent set of functions for basic linear algebra operations. Should you want to contribute you are more than welcome to!



## Installation
Simply add ELA to your list of dependencies in your mix.exs file, then run `mix deps.get`.
``` 
def deps do
    [{:elixir_linear_algebra, "~> 0.9.5", hex: :ela}]
end
``` 
## Implemented and planned features
- [x] Vector
  - [x] Addition
  - [x] Subtraction
  - [x] Scalar multiplication
  - [x] Dot product
  - [x] Cross product
  - [x] Hadmard product
  - [X] Euclidian norm
  
- [x] Matrix
  - [x] Addition
  - [x] Subtraction
  - [x] Scalar multiplication
  - [x] Vector multiplication
  - [x] Matrix multiplication
  - [x] Hadmard product
  - [x] Pivoting
  - [x] Reduced row echelon form
  - [x] LU decomposition
  - [x] Determinants

## Vector operations

Creation
``` 
iex> Vector.new(3)
[0, 0, 0]
```

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

Hadmard product
```
iax> Vector.hadmard([1, 2], [2, 2])
[2, 4]
```

Euclidian norm
``` 
iex> Vector.norm([3, 4])
0.5
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
```

``` 
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

Hadmard product
```
iex> Matrix.hadmard([[1, 2],
                     [1, 1]],
                    [[1, 2],
                     [0, 2]])
[[1, 4],
 [0, 2]]
```

Transpose
``` 
iex> Matrix.transp([[1, 2, 3],
                    [4, 5, 6]])
[[1, 4],
 [2, 5],
 [3, 6]]
```

Dimensions
```
iex> Matrix.dim([[1, 1, 1],
                 [2, 2, 2]])
{2, 3}
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

LU decomposition
Returns a LUP  decomposed matrix as a tuple.
```
iex> Matrix.lu([[1, 3, 5],
                [2, 4, 7],
                [1, 1, 0]])
{[[1,    0,  0],
  [0.5,  1,  0],
  [0.5, -1,  1]],
 [[2,  4,    7],
  [0,  1.0,  1.5],
  [0,  0,   -2.0]]
 [[0, 1, 0],
  [1, 0, 0],
  [0, 0, 1]]}
```


Determinant
```
iex> Matrix.det([[1, 3, 5],
                 [2, 4, 7],
                 [1, 1, 0]])
4
```