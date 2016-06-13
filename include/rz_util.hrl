-ifndef(RZ_UTIL_HRL).
-define(RZ_UTIL_HRL, true).

-type(instr_name() :: binary()).

-record(candle, {
  name :: instr_name(),
  open = 0 :: float(),
  close = 0 :: float(),
  high = 0 :: float(),
  low = 0 :: float(),
  vol = 0 :: float(),
  bid = 0 :: float(), % bid & ask используются только в текущей свече
  ask = 0 :: float()
}).

-endif.