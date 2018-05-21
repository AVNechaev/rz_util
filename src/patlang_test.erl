%%%-------------------------------------------------------------------
%%% @author an
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. May 2018 6:53 PM
%%%-------------------------------------------------------------------
-module(patlang_test).
-author("an").

%% API
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

%%--------------------------------------------------------------------
current_pattern_test() ->
  [
    ?assertEqual(ok, compile_pattern("Instr#D,1#PRICE > 0")),
    ?assertEqual(ok, compile_pattern("Instr#D,1#OPEN > 0")),
    ?assertEqual(ok, compile_pattern("Instr#D,1#BID > 0")),
    ?assertEqual(ok, compile_pattern("Instr#Price > 0"))
  ].
hist_pattern_test() ->
  [
    ?assertEqual(ok, compile_pattern("Instr#D,2#OPEN > Instr#D,3#CLOSE"))
  ].
arith_test() ->
  [
    ?assertEqual(ok, compile_pattern("((Instr#D,3#OPEN * 2) % (Instr#D,3#CLOSE / 4)) > 5")),
    ?assertEqual(ok, compile_pattern("3 < ((Instr#D,3#OPEN * 2) + (8 % Instr#D,3#CLOSE))"))
  ].
fixed_test() ->
  [
    ?assertEqual(ok, compile_pattern("FIXED_AURUSD.FXCM#D,1#BID > FIXED_DDX#D,2#CLOSE")),
    ?assertEqual(ok, compile_pattern("FIXED_AURUSD.FXCM#Ask > FIXED_DDX#D,2#CLOSE")),
    ?assertException(error, {badmatch, {error,{1,patterns_lex, _}, _}}, compile_pattern("FIXED_#Ask > FIXED_DDX#D,2#CLOSE"))
  ].
logic_test() ->
  [
    ?assertException(error, {badmatch, {error,{1,patterns_parser, _}}}, compile_pattern("Instr#D,2#OPEN * 3"))
  ].
varpath_test() ->
  [
    ?assertEqual(ok, compile_pattern("Instr#D,1#PRICE > 0")),
    ?assertException(error, {badmatch, {error,{1,patterns_parser, _}}}, compile_pattern("Instr#D,1#PRICE > 0;")),
    ?assertEqual(ok, compile_pattern("Instr#D,1#PRICE > 0;SomeVar:=Instr#Price;AnotherVar:=FIXED_DDX#D,2#CLOSE"))
  ].

compile_pattern(Text) ->
  {ok, Tokens, _} = patterns_lex:string(Text),
  {ok, {_, _}} = patterns_parser:parse(Tokens),
  ok.
