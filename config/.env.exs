defmodule EnvLoader do
  @moduledoc """
  Loads config variables from .env file
  """

  @env_file_path ".env"

  def load_env_vars do
    if File.exists?(@env_file_path) do
      File.read!(@env_file_path)
      |> String.split("\n", trim: true)
      |> Enum.filter(&(&1 != "" && !String.starts_with?(&1, "#")))
      |> Enum.map(fn line ->
        [key, value] = String.split(line, "=", parts: 2)
        {String.to_atom(String.trim(key)), String.trim(value)}
      end)
    else
      []
    end
  end
end

# Load the environment variables into a keyword list
env_vars = EnvLoader.load_env_vars()

# Set each variable if not already defined in the system
Enum.each(env_vars, fn {key, value} ->
  unless System.get_env(Atom.to_string(key)) do
    key |> Atom.to_string() |> System.put_env(value)
  end
end)
