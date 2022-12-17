defmodule FileHelpers.Reader do
  @spec read_file(String.t(), list) :: list
  def read_file(file_path, opts \\ []) do
    {:ok, file_contents} = File.read(file_path)
    String.split(file_contents, Keyword.get(opts, :delimiter, "\n"), trim: true)
  end

  @spec read_file_as_columns(String.t(), list) :: list
  def read_file_as_columns(file_path, opts \\ []) do
    {:ok, file_contents} = File.read(file_path)
    String.split(file_contents, Keyword.get(opts, :delimiter, "\n"), trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
end
