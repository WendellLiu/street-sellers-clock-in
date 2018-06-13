defmodule StreetSellersClockIn.ClockIn do
  @moduledoc """
  The ClockIn context.
  """

  import Ecto.Query, warn: false
  alias StreetSellersClockIn.Repo

  alias StreetSellersClockIn.ClockIn.ClockRecord

  @doc """
  Returns the list of clock_records.

  ## Examples

      iex> list_clock_records()
      [%ClockRecord{}, ...]

  """
  def list_clock_records do
    Repo.all(ClockRecord)
  end

  @doc """
  Gets a single clock_record.

  Raises `Ecto.NoResultsError` if the Clock record does not exist.

  ## Examples

      iex> get_clock_record!(123)
      %ClockRecord{}

      iex> get_clock_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock_record!(id), do: Repo.get!(ClockRecord, id)

  @doc """
  Creates a clock_record.

  ## Examples

      iex> create_clock_record(%{field: value})
      {:ok, %ClockRecord{}}

      iex> create_clock_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock_record(attrs \\ %{}) do
    %ClockRecord{}
    |> ClockRecord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock_record.

  ## Examples

      iex> update_clock_record(clock_record, %{field: new_value})
      {:ok, %ClockRecord{}}

      iex> update_clock_record(clock_record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock_record(%ClockRecord{} = clock_record, attrs) do
    clock_record
    |> ClockRecord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ClockRecord.

  ## Examples

      iex> delete_clock_record(clock_record)
      {:ok, %ClockRecord{}}

      iex> delete_clock_record(clock_record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock_record(%ClockRecord{} = clock_record) do
    Repo.delete(clock_record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock_record changes.

  ## Examples

      iex> change_clock_record(clock_record)
      %Ecto.Changeset{source: %ClockRecord{}}

  """
  def change_clock_record(%ClockRecord{} = clock_record) do
    ClockRecord.changeset(clock_record, %{})
  end
end
