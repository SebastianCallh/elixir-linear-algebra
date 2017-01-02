defmodule VectorTest do
  use ExUnit.Case, async: true

  alias ELA.Vector, as: Vector
  
  test "create vector" do
    assert Vector.new(3) === [0, 0, 0]
  end

  test "create vectors with non-number elements" do
    assert_raise ArgumentError, fn() -> Vector.new('b') end
  end

  test "multiplication with scalar" do
    v = [2, 2, 2]
    
    assert Vector.scalar(v, 2) == [4, 4, 4]
  end

  test "Dot product" do
    u = [1, 2, 1]
    v = [2, 2, 2]
    
    assert Vector.dot(u, v) == 8
  end

  test "multiply vectors with different size" do
    u = [1, 2, 1]
    v = [2, 2]
    
    assert_raise ArgumentError, fn() -> Vector.dot(u, v) end
  end

  test "multiply empty vectors" do
    u  = []
    v  = []
    
    assert Vector.dot(u , v ) === 0
  end

  test "add vectors" do
    u  = [1, 2, 1]
    v  = [2, 2, 2]
    
    assert Vector.add(u , v) === [3, 4, 3]
  end

  test "add vectors with different size" do
    u = [1, 2, 1]
    v = [2, 2]
    
    assert_raise ArgumentError, fn() -> Vector.add(u, v) end
  end

  test "adding empty vectors" do
    u = []
    v = []
    
    assert Vector.add(u, v) === []
  end

  test "subtracting vectors" do
    u = [1, 2, 1]
    v = [2, 2, 2]
    
    assert Vector.sub(u , v) == [-1, 0, -1]
  end

  test "subtracting vectors with different size" do
    u = [1, 2, 1]
    v = [2, 2]
    
    assert_raise ArgumentError, fn() -> Vector.sub(u, v) end
  end
  
  test "subtracting empty vectors" do
    u = []
    v = []
    
    assert Vector.sub(u, v) === []
  end

  test "cross product" do
    u = [1, 2, 1]
    v = [2, 2, 2]
    
    assert Vector.cross(u, v) === [2, 0, -2]
  end

  test "cross product with vectors not having three elements" do
    u = [1, 2]
    v = [2, 2]
    
    assert_raise ArgumentError, fn() -> Vector.cross(u, v) end
  end

  test "hadmard product" do
    u = [1, 2]
    v = [2, 2]
    
    assert Vector.hadmard(u, v) === [2, 4]
  end
  
  test "hadmard product for vectors with different size" do
    u = [1]
    v = [2, 2]
    
    assert_raise ArgumentError, fn() -> Vector.hadmard(u, v) end
  end

  test "transpose vector" do
    v = [1, 1, 1]
    u = Vector.transp(Vector.transp(v))
    
    assert u === v
  end

  test "norm of vector" do
    v = [3, 4]

    assert Vector.norm(v) === 5.0
  end
end
