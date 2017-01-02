defmodule ELA.Vector do
  alias :math, as: Math
  
  @moduledoc"""
  Contains  operations for working with vectors.
  """

  @doc"""
  Returns a vector with zeroes with provided dimension.
  
  ## Examples
     
      iex> Vector.new(3)
      [0, 0, 0]

  """
  @spec new(number) :: [number]
  def new(n) when not is_number(n),
  do: raise(ArgumentError, "Size provide has to be a number.")
  def new(n) do
    for _ <- 1..n, do: 0
  end
    
  @doc"""
  Performs elementwise addition.

  ## Examples
    
      iex> Vector.add([1, 2, 1], [2, 2, 2])
      [3, 4, 3]
      
  """
  @spec add([number], [number]) :: [number]
  def add(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  def add(u, v) do
    for {a, b} <- Enum.zip(u, v), do: a + b
  end

  @doc"""
  Performs elementwise subtraction.

  ## Examples
    
      iex> Vector.sub([1, 2, 1], [2, 2, 2])
      [-1, 0, -1]

  """
  @spec sub([number], [number]) :: [number]
  def sub(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  @spec sub([number], [number]) :: [number]
  def sub(u, v) do
    add(u, Enum.map(v, fn(x) -> -x end))
  end

  @doc"""
  Performs elementwise multiplication between two vectors. 
  This is the Hadmard product, but for vectors.

  ## Examples
    
      iax> Vector.hadmard([1, 2], [2, 2])
      [2, 4]
  
  """
  @spec hadmard([number], [number]) :: [number]
  def hadmard(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  def hadmard(u, v) do
    Enum.zip(u, v) |> Enum.map(fn({a, b}) -> a*b end)
  end

  @doc"""
  Calculates the cross product.
  Is only defined for vectors with size three.

  ## Examples      

      iex> Vector.cross([1, 2, 1], [2, 2, 2])
      [2, 0, -2]

  """
  @spec cross([number], [number]) :: [number]
  def cross(u, v) when length(u) !== 3 and length(v) !== 3,
  do: raise(ArgumentError, "The cross product is only defined for vectors with three elements.")
  def cross(u, v) do
    u = List.to_tuple(u)
    v = List.to_tuple(v)
    [elem(u, 1)*elem(v, 2) - elem(u, 2)*elem(v, 1),
     elem(u, 2)*elem(v, 0) - elem(u, 0)*elem(v, 2),
     elem(u, 0)*elem(v, 1) - elem(u, 1)*elem(v, 0)]
  end

  @doc"""
  Elementwise multiplication with a scalar.

  ## Examples      

      iex> Vector.scalar([2, 2, 2], 2)
      [4, 4, 4]

  """
  @spec scalar([number], number) :: [number]
  def scalar(v, s) do
    Enum.map(v, fn(x) -> x*s end)
  end

  @doc"""
  Calculates the dot product.
  Multiplying empty vectors return 0.

  ## Examples
    
      iex> Vector.dot([1, 2, 1], [2, 2, 2])
      8
  
  """
  @spec dot([number], [number]) :: number
  def dot(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  def dot(u, v) do
    Enum.zip(u, v) |> Enum.reduce(0, fn({a, b}, acc) -> acc + a*b end)
  end

  @doc"""
  Transponates the vector. Column vectors are two-dimensional.

  ## Examples
  
      iex> Vector.transp([1, 1, 1])
      [[1],
      [1],
      [1]]
    
  """
  def transp(v) when is_number(hd(v)) do
    Enum.map(v, fn(x) -> [x] end)
  end
  def transp(v) when is_list(hd(v)) do
    List.flatten(v)
  end

  @doc"""
  Calculates the euclidian norm of a vector.

  ## Examples
  
      iex> Vector.norm([3, 4])
      0.5
      
  """
  @spec norm([number]) :: number
  def norm(v) do
    Enum.reduce(v, 0, fn(e, acc) -> acc + Math.pow(e, 2) end)
    |> Math.sqrt()
  end
end
