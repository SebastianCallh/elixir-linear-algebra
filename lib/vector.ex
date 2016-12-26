defmodule ELA.Vector do
  alias :math, as: Math
  
  @moduledoc"""
  Contains  operations for working with vectors.
  """

  @doc"""
  Returns an empty vector with provided dimension.
  """
  @spec new(number) :: [number]
  def new(n) when not is_number(n),
  do: raise(ArgumentError, "Size provide has to be a number.")
  def new(n) do
    for _ <- 1..n, do: 0
  end
    
  @doc"""
  Performs elementwise addition.
  """
  @spec add([number], [number]) :: [number]
  def add(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  def add(u, v) do
    for {a, b} <- Enum.zip(u, v), do: a + b
  end

  @doc"""
  Performs elementwise subtraction.
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
  """
  @spec scalar([number], number) :: [number]
  def scalar(v, s) do
    Enum.map(v, fn(x) -> x*s end)
  end

  @doc"""
  Calculates the dot product.
  Multiplying empty vectors return 0.
  """
  @spec dot([number], [number]) :: number
  def dot(u, v) when length(u) !== length(v),
  do: raise(ArgumentError, "The number of elements in the vectors must match.")
  def dot(u, v) do
    Enum.zip(u, v) |> Enum.reduce(0, fn({a, b}, acc) -> acc + a*b end)
  end

  @doc"""
  Transponates the vector. Column vectors are two-dimensional.
  """
  def transp(v) when is_number(hd(v)) do
    Enum.map(v, fn(x) -> [x] end)
  end
  def transp(v) when is_list(hd(v)) do
    List.flatten(v)
  end

  @doc"""
  Calculates the norm of a vector.
  """
  @spec norm([number]) :: number
  def norm(v) do
    Enum.reduce(v, 0, fn(e, acc) -> acc + Math.pow(e, 2) end)
    |> Math.sqrt()
  end
end
