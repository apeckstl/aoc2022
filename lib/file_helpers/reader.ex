defmodule FileHelpers.Reader do
  @spec read_file(String.t(), list) :: list
  def read_file(file_path, opts \\ []) do
    {:ok, file_contents} = File.read(file_path)
    String.split(file_contents, Keyword.get(opts, :delimiter, "\n"), trim: true)
  end
end
