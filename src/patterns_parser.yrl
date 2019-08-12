Nonterminals pattern logic_value arith_value var_list.

Terminals instr fixed_instr two_op_logic comparator constant two_op_arith open_bracket close_bracket var_divider variable assignment time_code.

Rootsymbol pattern.

Left 100 two_op_logic.
Left 200 comparator.
Left 300 two_op_arith.

pattern -> logic_value : {undefined, '$1', undefined}.
pattern -> logic_value var_divider var_list : {undefined, '$1', '$3'}.
pattern -> time_code var_divider logic_value : {'$1', '$3', undefined}.
pattern -> time_code var_divider logic_value var_divider var_list : {'$1', '$3', '$5'}.

logic_value -> logic_value two_op_logic logic_value : {'$2', '$1', '$3'}.
logic_value -> arith_value comparator arith_value : {'$2', '$1', '$3'}.
logic_value -> open_bracket logic_value close_bracket : '$2'.

arith_value -> arith_value two_op_arith arith_value : {'$2', '$1', '$3'}.

arith_value -> constant : '$1'.
arith_value -> instr : '$1'.
arith_value -> fixed_instr : '$1'.
arith_value -> open_bracket arith_value close_bracket : '$2'.

var_list -> variable assignment arith_value : {'$1', '$3', undefined}.
var_list -> variable assignment arith_value var_divider var_list : {'$1', '$3', '$5'}.

