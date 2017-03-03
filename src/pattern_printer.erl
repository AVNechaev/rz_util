%%%-------------------------------------------------------------------
%%% @author user
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. Март 2017 18:09
%%%-------------------------------------------------------------------
-module(pattern_printer).
-author("user").

%% API
-export([print/1]).

print(Text) ->
  {ok, T, _} = patterns_lex:string(Text),
  {ok, R} = patterns_parser:parse(T),
  io:format("digraph res {~n"),
  pprint(R, 0),
  io:format("}~n").


pprint({constant, _, V}, Num) ->
  io:format("f~p [label=\"const ~p\"];~n", [Num, V]),
  Num+1;
pprint({instr, _, Text}, Num) ->
  io:format("f~p [label=\"~s\"];~n", [Num, Text]),
  Num+1;
pprint({{_, _, V}, Left, Right}, Num) ->
  LNum = pprint(Left, Num+1),
  RNum = pprint(Right, LNum),
  io:format("f~p [label=\"~s\"];~n", [Num, any2string(V)]),
  io:format("f~p -> f~p;~n", [Num, Num+1]),
  io:format("f~p -> f~p;~n", [Num, LNum]),
  RNum.

any2string(V) when is_list(V) -> V;
any2string(V) when is_atom(V) -> atom_to_list(V).