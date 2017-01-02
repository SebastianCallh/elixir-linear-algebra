defmodule MatrixTest do
  use ExUnit.Case, async: true
  doctest ELA.Matrix

  alias ELA.Matrix, as: Matrix
  alias ELA.Vector, as: Vector

  test "create matrix" do
    assert Matrix.new(3, 2) == [[0, 0],
				[0, 0],
				[0, 0]]
  
  end

  test "create identity matrix" do
    assert Matrix.identity(3) === [[1, 0, 0],
				   [0, 1, 0],
				   [0, 0, 1]]
  end

  test "Transposing matrix with fewer columns than rows" do
    a = [[1, 2],
	 [3, 4],
	 [5, 6]]
    b = [[1, 3, 5],
	 [2, 4, 6]]
    
    assert Matrix.transp(a) === b
  end
  
  test "Transposing matrix with more columns than rows" do
    a = [[1, 2, 3],
	 [4, 5, 6]]
    b = [[1, 4],
	 [2, 5],
	 [3, 6]]
    
    assert Matrix.transp(a) === b
  end

  test "add matrices" do
    a = [[1, 2, 3],
	 [1, 1, 1]]
    b = [[1, 2, 2],
	 [1, 2, 1]]
    
    assert Matrix.add(a, b) === [[2, 4, 5],
				 [2, 3, 2]]
  end
  
  test "add matrices with different number of cols" do
    a = [[1, 2]]
    b = [[1, 2],
	 [3, 4]]
    
    assert_raise ArgumentError, fn() -> Matrix.add(a, b) end
  end

  test "add matrices with different number of rows" do
    a = [[1, 2, 3]]
    b = [[1, 2, 3],
	 [4, 5, 6]]
    
    assert_raise ArgumentError, fn() -> Matrix.add(a, b) end
  end

  test "subtract matrices" do
    a = [[1, 2, 3],
	 [1, 2, 2]]
    b = [[1, 2, 3],
	 [2, 2, 2]]
    
    assert Matrix.sub(a, b) === [[0, 0, 0],
				 [-1, 0, 0]]
  end

  test "subtract matrices with different number of cols" do
    a = [[1, 2, 3],
	 [4, 5, 6]]
    b = [[1, 2],
	 [3, 4]]
    
    assert_raise ArgumentError, fn() -> Matrix.sub(a, b) end
  end

  test "subtract matrices with different number of rows" do
    a = [[1, 2, 3]]
    b = [[1, 2, 3],
	 [4, 5, 6]]
    
    assert_raise ArgumentError, fn() -> Matrix.sub(a, b) end
  end
  
  test "multiplication with scalar" do
    a = [[2, 2, 2],
	 [1, 1, 1]]
    
    assert Matrix.scalar(a, 2) == [[4, 4, 4],
				   [2, 2, 2]]
  end

  test "multiplication of matrices" do
    a = [[1, 2],
	 [1, 1]]
    b = [[1, 2],
	 [0, 2]]
    
    assert Matrix.mult(a, b) === [[1, 6],
				  [1, 4]]
  end

  test "vector multiplied with matrix" do
    v = [1, 1]
    a = [[1, 0, 1],
	 [1, 1, 1]]

    assert Matrix.mult(v, a) === [[2, 1, 2]]
  end

  test "matrix multiplied with vector" do
    v = Vector.transp([1, 1, 1])
    a = [[1, 0, 1],
	 [1, 1, 1]]
    
    assert Matrix.mult(a, v) === [[2],
				  [3]]
  end

  test "multiplication with vector with to big dimension" do
    a = [[1, 2, 3],
	 [1, 1, 1]]
    b = [[1, 2],
	 [0, 2]]
    
    assert_raise ArgumentError, fn() -> Matrix.mult(a, b) end
  end

  test "multiplication with vector with too small dimension" do
    a = [[1],
	 [1]]
    b = [[1, 2],
	 [0, 2]]
    
    assert_raise ArgumentError, fn() -> Matrix.mult(a, b) end
  end

  test "hadmard product of two matrices" do
    a = [[1, 2],
	 [1, 1]]
    b = [[1, 2],
	 [0, 2]]
    
    assert Matrix.hadmard(a, b) === [[1, 4],
				     [0, 2]]
  end

  test "hadmard product with different number of cols" do
    a = [[1],
	 [1]]
    b = [[1, 2],
	 [0, 2]]
    
    assert_raise ArgumentError, fn() -> Matrix.hadmard(a, b) end
  end

  test "hadmard product with different number of rows" do
    a = [[1, 2],
	 [1, 2]]
    b = [[1, 2]]
    
    assert_raise ArgumentError, fn() -> Matrix.hadmard(a, b) end
  end

  test "matrix dimensions" do
    a = [[1, 1, 1],
	 [2, 2, 2]]
    
    assert Matrix.dim(a) === {2, 3}
  end

  test "pivoting an element" do
    a = [[2.0, 3.0],
	 [2.0, 3.0],
	 [3.0, 6.0]]

    assert Matrix.pivot(a, 1, 0) === [[0.0, 0.0],
				      [1.0, 1.5],
				      [0.0, 1.5]]
  end

  
  test "reduced row echelon form with more columns than rows" do
    a = [[1.0, 1.0, 2.0, 1.0],
	 [2.0, 1.0, 6.0, 4.0],
	 [1.0, 2.0, 2.0, 3.0]]

    assert Matrix.reduce(a) === [[1.0, 0.0, 0.0, -5.0],
			        [0.0, 1.0, 0.0, 2.0],
			        [0.0, 0.0, 1.0, 2.0]]
  end

  test "reduced row echelon form with less columns than rows" do
    a = [[1.0, 2.0],
	 [2.0, 3.0],
	 [3.0, 6.0],
	 [3.0, 6.0]]

    assert Matrix.reduce(a) === [[1.0, 0.0],
			        [0.0, 1.0],
				[0.0, 0.0],
				[0.0, 0.0]]
  end
  
end
