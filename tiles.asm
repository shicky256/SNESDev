.segment "CODE"

TILE_HARD = $0 ; if player is ejected from tile

TileAttrs: ;either "hard" aka eject or pointer to heightmap
.word TILE_HARD
.word TILE_HARD
.word HeightMap4

HeightMap4: ;height map for tile 4
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
.word $1
