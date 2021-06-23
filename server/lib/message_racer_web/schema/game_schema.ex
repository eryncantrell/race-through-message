#
#  game_schema.ex
#  server
#
#  Created by d-exclaimation on 11:22.
#

defmodule MessageRacerWeb.GameSchema do
  @moduledoc """
  Game Event Schema
  """
  use Absinthe.Schema.Notation
  alias MessageRacerWeb.Event.{Delta, Join, Start, End}

  @desc "A game event"
  union :game_event do
    types([:end_event, :delta_event, :join_event, :start_event])

    resolve_type(fn
      %Delta{}, _ -> :delta_event
      %Join{}, _ -> :join_event
      %Start{}, _ -> :start_event
      %End{}, _ -> :end_event
    end)
  end

  @desc "Event to stop force leave all users"
  object :end_event do
    field :type, non_null(:event_type)
  end

  @desc "Event to send in valid changes"
  object :delta_event do
    field :type, non_null(:event_type)
    field :index, non_null(:integer)
    field :username, non_null(:string)
    field :word, non_null(:string)
  end

  @desc "Event to add new players"
  object :join_event do
    field :type, non_null(:event_type)
    field :username, non_null(:string)
  end

  @desc "Event to trigger start for each player"
  object :start_event do
    field :type, non_null(:event_type)

    # TODO: Send in the paragraph
  end

  @desc "Event type"
  enum(:event_type, values: [:end, :join, :start, :delta])
end
