defmodule ELA.Matrix do
  alias  ELA.Vector, as: Vector

  @moduledoc"""
  Contains  operations for working with matrices.
  """

  @doc"""
  Returns an identity matrix with the provided dimension.
  """
  @spec identity(number) ::[[number]]
  def identity(n) do
    for i <- 1..n, do: for j <- 1..n, do: (fn
      i, j when i === j -> 1
      _, _ -> 0
    end).(i, j)
  end
  
  @doc"""
  Returns a matrix filled wiht zeroes as with n rows and m columns.
  """
  @spec new(number, number) :: [[number]]
  def new(n, m) do
    for _ <- 1..n, do: for _ <- 1..m, do: 0
  end
  
  @docs"""
  Transposes a matrix.
  """
  @spec transp([[number]]) :: [[number]]
  def transp(a) do
    List.zip(a) |> Enum.map(&Tuple.to_list(&1))
  end

  @doc"""
  Performs elmentwise addition
  """
  @spec add([[number]], [[number]]) :: [[number]]
  def add(a, b) do
    if dim(a) !== dim(b) do
      raise(ArgumentError, "Matrices must have same dimensions for addition.")
    end
    Enum.map(Enum.zip(a, b), fn({a, b}) -> Vector.add(a, b) end)
  end

  @doc"""
  Performs elementwise subtraction
  """
  @spec sub([[number]], [[number]]) :: [[number]]
  def sub(a, b) when length(a) !== length(b),
  do: raise(ArgumentError, "The number of rows in the matrices must match.")
  def sub(a, b) do
    Enum.map(Enum.zip(a, b), fn({a, b}) -> Vector.add(a, Vector.scalar(b, -1)) end)
  end

  @doc"""
  Elementwise mutiplication with a scalar.
  """
  @spec scalar([[number]], number) :: [[number]]
  def scalar(a, s) do
    Enum.map(a, fn(r) -> Vector.scalar(r, s) end)
  end
  
  @doc"""
  Elementwise multiplication with two matrices.
  This is known as the Hadmard product.
  """
  def hadmard(a, b) when length(a) !== length(b),
  do: raise(ArgumentError, "The number of rows in the matrices must match.")
  def hadmard(a, b) do
    Enum.map(Enum.zip(a, b), fn({u, v}) -> Vector.hadmard(u, v) end)
  end

  @doc"""
  Matrix multiplication. Can also multiply matrices with vectors.
  Always returns a matrix.
  """
  def mult(v, b) when is_number(hd(v)) and is_list(hd(b)), do: mult([v], b)
  def mult(a, v) when is_number(hd(v)) and is_list(hd(a)), do: mult(a, [v])
  def mult(a, b) do
    Enum.map(a, fn(r) ->
      Enum.map(transp(b), &Vector.dot(r, &1))
    end)
  end
  
  @doc"""
  Returns a tuple with the matrix dimensions as {rows, cols}.
  """
  @spec dim([[number]]) :: {integer, integer}
  def dim(a) when length(a) === 0, do: 0
  def dim(a) do
    {length(a), length(Enum.at(a, 0))}
  end

  @doc"""
  Pivots them matrix a on the element on row n, column m (zero indexed).
  Pivoting performs row operations to make the 
  pivot element 1 and all others in the same column 0.
  """
  @spec pivot([[number]], number, number) :: [[number]]
  def pivot(a, n, m) do
    pr = Enum.at(a, n)  #Pivot row
    pe = Enum.at(pr, m) #Pivot element

    a
    |> List.delete_at(n)
    |> Enum.map(&Vector.sub(&1, Vector.scalar(pr, Enum.at(&1, m) / pe)))
    |> List.insert_at(n, Vector.scalar(pr, 1 / pe))
  end
  
  @doc"""
  Returns a row equivalent matrix on reduced row echelon form.
  """
  @spec reduce([[number]]) :: [[number]]
  def reduce(a, i \\ 0)  
  def reduce(a, i) do
    r = Enum.at(a, i)
    j = Enum.find_index(r, fn(e) -> e != 0 end)
    a = pivot(a, i, j)
    
    unless j === length(r) - 1 or
           i === length(a) - 1
      do
        reduce(a, i + 1)
      else
	a
    end
  end
end
