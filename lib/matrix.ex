defmodule ELA.Matrix do
  alias  ELA.Vector, as: Vector

  @moduledoc"""
  Contains  operations for working with matrices.
  """

  @doc"""
  Returns an identity matrix with the provided dimension.

  ## Examples
      
      iex> Matrix.identity(3)
      [[1, 0, 0],
       [0, 1, 0],
       [0, 0, 1]]

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

  ## Examples
    
      iex> Matrix.new(3, 2)
      [[0, 0],
       [0, 0],
       [0, 0]]
  
  """
  @spec new(number, number) :: [[number]]
  def new(n, m) do
    for _ <- 1..n, do: for _ <- 1..m, do: 0
  end
  
  @doc"""
  Transposes a matrix.

  ## Examples

      iex> Matrix.transp([[1, 2, 3], [4, 5, 6]])
      [[1, 4],
       [2, 5],
       [3, 6]]

  """
  @spec transp([[number]]) :: [[number]]
  def transp(a) do
    List.zip(a) |> Enum.map(&Tuple.to_list(&1))
  end

  @doc"""
  Performs elmentwise addition

  ## Examples
  
      iex> Matrix.add([[1, 2, 3],
      ...>             [1, 1, 1]],
      ...>            [[1, 2, 2],
      ...>             [1, 2, 1]])
      [[2, 4, 5],
       [2, 3, 2]]

  """
  @spec add([[number]], [[number]]) :: [[number]]
  def add(a, b) do
    if dim(a) !== dim(b) do
      raise(ArgumentError, "Matrices #{inspect a}, #{inspect b} must have same dimensions for addition.")
    end
    Enum.map(Enum.zip(a, b), fn({a, b}) -> Vector.add(a, b) end)
  end

  @doc"""
  Performs elementwise subtraction

  ## Examples

      iex> Matrix.sub([[1, 2, 3],
      ...>             [1, 2, 2]],
      ...>            [[1, 2, 3],
      ...>             [2, 2, 2]])
      [[0, 0, 0],
       [-1, 0, 0]]

  """
  @spec sub([[number]], [[number]]) :: [[number]]
  def sub(a, b) when length(a) !== length(b),
  do: raise(ArgumentError, "The number of rows in the matrices must match.")
  def sub(a, b) do
    Enum.map(Enum.zip(a, b), fn({a, b}) -> Vector.add(a, Vector.scalar(b, -1)) end)
  end

  @doc"""
  Elementwise mutiplication with a scalar.

  ## Examples
    
      iex> Matrix.scalar([[2, 2, 2],
      ...>                [1, 1, 1]], 2)
      [[4, 4, 4],
       [2, 2, 2]]

  """
  @spec scalar([[number]], number) :: [[number]]
  def scalar(a, s) do
    Enum.map(a, fn(r) -> Vector.scalar(r, s) end)
  end
  
  @doc"""
  Elementwise multiplication with two matrices.
  This is known as the Hadmard product.

  ## Examples
    
      iex> Matrix.hadmard([[1, 2],
      ...>                 [1, 1]],
      ...>                [[1, 2],
      ...>                 [0, 2]])
      [[1, 4],
       [0, 2]]

  """
  def hadmard(a, b) when length(a) !== length(b),
  do: raise(ArgumentError, "The number of rows in the matrices must match.")
  def hadmard(a, b) do
    Enum.map(Enum.zip(a, b), fn({u, v}) -> Vector.hadmard(u, v) end)
  end

  @doc"""
  Matrix multiplication. Can also multiply matrices with vectors.
  Always returns a matrix.

  ## Examples

      iex> Matrix.mult([1, 1], 
      ...>             [[1, 0, 1],
      ...>              [1, 1, 1]])
      [[2, 1, 2]]

      iex> Matrix.mult([[1, 0, 1],
      ...>              [1, 1, 1]],
      ...>              [[1],
      ...>               [1],
      ...>               [1]])
      [[2],
       [3]]

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

  ## Examples

      Matrix.dim([[1, 1, 1],
      ...>        [2, 2, 2]])
      {2, 3}

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

  ## Examples
    
      iex> Matrix.pivot([[2.0, 3.0],
      ...>               [2.0, 3.0],
      ...>               [3.0, 6.0]], 1, 0)
      [[0.0, 0.0],
       [1.0, 1.5],
       [0.0, 1.5]]

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

  ## Examples
    
      iex> Matrix.reduce([[1.0, 1.0, 2.0, 1.0],
      ...>                [2.0, 1.0, 6.0, 4.0],
      ...>                [1.0, 2.0, 2.0, 3.0]])
      [[1.0, 0.0, 0.0, -5.0],
       [0.0, 1.0, 0.0, 2.0],
       [0.0, 0.0, 1.0, 2.0]]

  """
  @spec reduce([[number]]) :: [[number]]
  def reduce(a), do: reduce(a, 0)
  defp reduce(a, i) do
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

  @doc"""
  Returns the determinat of the matrix. Uses LU-decomposition to calculate it.

  #Examples

      iex> Matrix.det([[1, 3, 5],
      ...>             [2, 4, 7],
      ...>             [1, 1, 0]])
      4

  """
  def det(a) when length(a) !== length(hd(a)),
  do: raise(ArgumentError, "Matrix #{inspect a} must be square to have a determinant.")
  def det(a) do
    {a, p} = lu(a)

    a_dia = diagonal(a)
    p_dia = diagonal(p)
    a_det = Enum.reduce(a_dia, 1, &*/2)
    exp = Enum.count(Enum.filter(p_dia, &(&1 === 0)))/2
    a_det * :math.pow(-1, exp)
  end

  @doc"""
  Returns a list of the matrix diagonal elements.

  ##Examples
      
      iex> Matrix.diagonal([[1, 3, 5],
      ...>                  [2, 4, 7],
      ...>                  [1, 1, 0]])
      [1, 4, 0]

  """
  def diagonal(a) when length(a) !== length(hd(a)),
  do: raise(ArgumentError, "Matrix #{inspect a} must be square to have a diagonal.")
  def diagonal(a), do: diagonal(a, 0)  
  defp diagonal([], _), do: []
  defp diagonal([h | t], i) do
    [Enum.at(h, i)] ++ diagonal(t, i + 1)
  end

  @doc"""
  Returns an LU-decomposed matrix with the permutation matrix used on the form {a, p}.

  ## Examples
    
      iex> Matrix.lu([[1, 3, 5],
      ...>            [2, 4, 7],
      ...>            [1, 1, 0]])
      {[[2,  4,  7],
        [0.5,  1.0,  1.5],
        [0.5,  -1.0, -2.0]],
       [[0, 1, 0],
        [1, 0, 0],
        [0, 0, 1]]}

  """
  def lu(a) do
    p = lu_perm_matrix(a)
    a = mult(p, a)
    a = lu_map_matrix(a)

    a = lu_rows(a)
    a = Enum.map(a, fn({_, v}) -> Enum.map(v, fn({_, v}) -> v end) end)
    {a, p}
  end

  defp lu_rows(a), do: lu_rows(a, 1)
  defp lu_rows(a, i) when i === map_size(a) + 1, do: a
  defp lu_rows(a, i) do
    lu_rows(lu_row(a, i), i + 1)
  end

  defp lu_row(a, i), do: lu_row(a, i, 1)
  defp lu_row(a, _, j) when j === map_size(a) + 1, do: a
  defp lu_row(a, i, j) do
    lu_row(Map.put(a, i, Map.put(a[i], j, parse(a, i, j))), i, j + 1)
  end

  defp parse(a, 1, j), do: a[1][j]          #Guard for the case where k <- 1..0
  defp parse(a, i, 1), do: a[i][1]/a[1][1]  #Guard for the case where k <- 1..0
  defp parse(a, i, j) when i > j do
    (a[i][j] - Enum.sum(for k <- 1..j-1, do: a[k][j] * a[i][k]))/a[j][j]
  end
  defp parse(a, i, j) when i <= j do
    a[i][j] - Enum.sum(for k <- 1..i-1, do: a[k][j] * a[i][k])
  end


  @spec lu_perm_matrix([[number]]) :: [[number]]
  defp lu_perm_matrix(a), do: lu_perm_matrix(transp(a), identity(length(a)), 0)
  defp lu_perm_matrix(a, p, i) when i === length(a) - 1, do: p
  defp lu_perm_matrix(a, p, i) do
    r = Enum.drop(Enum.at(a, i), i)
    
    j = i + Enum.find_index(r, fn(x) ->
      x === abs(Enum.max(r))
    end)

    p = 
      case {i, j} do
	{i, i} -> p
	_ -> p
	  |> List.update_at(i, &(&1 = Enum.at(p, j)))
	  |> List.update_at(j, &(&1 = Enum.at(p, i)))
      end
    
    lu_perm_matrix(a, p, i + 1)
  end

  defp lu_map_matrix(l, m \\ %{}, i \\ 1)
  defp lu_map_matrix([], m, _), do: m
  defp lu_map_matrix([h|t], m, i) do
    m = Map.put(m, i, lu_map_matrix(h))
    lu_map_matrix(t, m, i + 1)
  end
  defp lu_map_matrix(other, _, _), do: other
end
