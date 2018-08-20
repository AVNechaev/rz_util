Definitions.

VarChar = [a-zA-Z]
D = [0-9]
Frame = (D|H[1-9]|[1-9]|[1-9][0-9])
Cmp = (>|<|>=|<=|=)
WS  = [\000-\s]
%offset - от 1 до 22
HistOffset = ([2-9]|1[0-9]|2[0-2])
HistValue = (OPEN|CLOSE|HIGH|LOW|VOLUME)
CurValue = (OPEN|PRICE|HIGH|LOW|BID|ASK|VOLUME)
ShortCurValue = (Price|Bid|Ask)
InstrName = Instr
FixedName = ({VarChar}+|{VarChar}+\.{VarChar}+)
FixedInstr = (FIXED_{FixedName})

Rules.


{InstrName}#{Frame},1#{CurValue}                  : {token, {instr, TokenLine, TokenChars}}.
{InstrName}#{Frame},{HistOffset}#{HistValue}      : {token, {instr, TokenLine, TokenChars}}.
{InstrName}#{ShortCurValue}                       : {token, {instr, TokenLine, TokenChars}}.

{FixedInstr}#{Frame},1#{CurValue}                  : {token, {fixed_instr, TokenLine, TokenChars}}.
{FixedInstr}#{Frame},{HistOffset}#{HistValue}      : {token, {fixed_instr, TokenLine, TokenChars}}.
{FixedInstr}#{ShortCurValue}                       : {token, {fixed_instr, TokenLine, TokenChars}}.

Instr#{Frame}#sma20|Instr#{Frame}#SMA20           : {token, {instr, TokenLine, {sma, sma20, TokenChars}}}.
Instr#{Frame}#sma50|Instr#{Frame}#SMA50           : {token, {instr, TokenLine, {sma, sma50, TokenChars}}}.
Instr#{Frame}#sma200|Instr#{Frame}#SMA200         : {token, {instr, TokenLine, {sma, sma200, TokenChars}}}.

and|AND                                     : {token, {two_op_logic, TokenLine, op_and}}.
or|OR                                       : {token, {two_op_logic, TokenLine, op_or}}.

:\=                                         : {token, {assignment, TokenLine, none}}.

{Cmp}                                       : {token, {comparator, TokenLine, TokenChars}}.

{D}+                                      : {token, {constant, TokenLine, list_to_float(TokenChars ++ ".0")}}.
{D}+\.{D}+                                : {token, {constant, TokenLine, list_to_float(TokenChars)}}.
{D}+\,{D}+                                : {token, {constant, TokenLine, list_to_float(TokenChars)}}.

\-{D}+                                      : {token, {constant, TokenLine, list_to_float(TokenChars ++ ".0")}}.
\-{D}+\.{D}+                                : {token, {constant, TokenLine, list_to_float(TokenChars)}}.
\-{D}+\,{D}+                                : {token, {constant, TokenLine, list_to_float(TokenChars)}}.


\%                                          : {token, {two_op_arith, TokenLine, op_rem}}.
\+                                          : {token, {two_op_arith, TokenLine, op_plus}}.
-                                           : {token, {two_op_arith, TokenLine, op_minus}}.
\*                                          : {token, {two_op_arith, TokenLine, op_multiply}}.
\/                                          : {token, {two_op_arith, TokenLine, op_divide}}.
\(                                          : {token, {open_bracket, TokenLine, none}}.
\)                                          : {token, {close_bracket, TokenLine, none}}.
\;                                          : {token, {var_divider, TokenLine, none}}.
{VarChar}+                                  : {token, {variable, TokenLine, TokenChars}}.

{WS}+                                       : skip_token.


Erlang code.
