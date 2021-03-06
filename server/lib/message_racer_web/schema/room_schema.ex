#
#  room_schema.ex
#  server
#
#  Created by d-exclaimation on 12:25.
#

defmodule MessageRacerWeb.RoomSchema do
  @moduledoc """
  Room Schema
  """
  alias MessageRacer.PlayerLoader
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 3]

  import_types(MessageRacerWeb.PlayerSchema)

  @desc "Room Object type"
  object :room do
    @desc "Identifier"
    field :id, non_null(:id)

    @desc "Players joined in this room"
    field :players, non_null(list_of(non_null(:player))) do
      resolve(dataloader(PlayerLoader, :players, []))
    end
  end

  @desc "Host creation object"
  object :host_info do
    @desc "Host player who created the room"
    field :host, non_null(:player)
    @desc "Room created"
    field :room, non_null(:room)
  end

  @desc "Unvalidated changes input"
  input_object :delta_input do
    @desc "Room ID to sent this to"
    field :room_id, non_null(:id)
    @desc "Identification"
    field :username, non_null(:string)
    @desc "Changes candidate"
    field :changes, non_null(:changes)
  end

  @desc "Changes candidate"
  input_object :changes do
    @desc "Index currently on"
    field :index, non_null(:integer)
    @desc "Word currently on"
    field :word, non_null(:string)
  end
end
