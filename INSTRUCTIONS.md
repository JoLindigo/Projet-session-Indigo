SET_ACTOR_TILE_BUFFER_ID : 0000
||  4 |   6    | 3    | 3    |    5     | 11      ||
 OPCODE TILE_ID TILE_X TILE_Y TILE_COLOR  UA

MOVE_ACTOR_RELATIVE : 0100
||  4 |   6    | 10       | 10        | 3 ||
 OPCODE TILE_ID OFFSET_X   OFFSET_Y     UA

MOVE_ACTOR_ABSOLUTE : 0101
||  4 |   6    | 10       | 10        | 3 ||
 OPCODE TILE_ID OFFSET_X   OFFSET_Y     UA
