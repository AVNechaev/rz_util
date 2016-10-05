-ifndef(RZ_UTIL_HRL).
-define(RZ_UTIL_HRL, true).

-type(instr_name() :: binary()).

-type(sma_values() :: [{SMAName :: atom(), SMATextName :: string() | binary(), Value :: float()}]).

-record(candle, {
  name :: instr_name(),
  open = 0 :: float(),
  close = 0 :: float(),
  high = 0 :: float(),
  low = 0 :: float(),
  vol = 0 :: float(),
  bid = 0 :: float(), % bid & ask ������������ ������ � ������� �����
  ask = 0 :: float(),
  smas = [] :: sma_values()
}).

-endif.