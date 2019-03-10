.segment "BANK2"
FontPalette:
	.INCBIN ".\art\font.clr"
FontTiles:
	.INCBIN ".\art\font.pic"
	
PlayerPalette:
	.INCBIN ".\art\player.clr"
PlayerTiles:
	.INCBIN ".\art\player.pic"
	
BGPalette:
	.INCBIN ".\art\bgtiles.clr"
BGTiles:
	.incbin ".\art\bgtiles.pic"
	
BG2Palette:
	.INCBIN ".\art\bg2tiles.clr"
BG2Tiles:
	.incbin ".\art\bg2tiles.pic"

BGRightLim:
	.word $580 ;player X to lock at

BGTilemap: ;14 columns tall ($380 bytes) because SNES screen is 14 tiles tall (14*16=224)
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$2,$0,$0,$2,$0,$0,$0,$0,$2,$2,$0,$0,$2,$0,$0,$2,$0,$0,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$2,$0,$0,$2,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$0,$0,$4,$2,$4004,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$0,$0,$0,$6,$8,$2,$2,$2,$4004,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2
	
BGTilemapPt2: ;14 columns tall ($380 bytes) because SNES screen is 14 tiles tall (14*16=224)
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$2,$0,$0,$2,$0,$0,$0,$0,$2,$2,$0,$0,$2,$0,$0,$2,$0,$0,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$2,$0,$0,$2,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$4,$2,$4004,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$6,$8,$2,$2,$2,$4004,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2
	
BGTilemapPt3: ;part that gets scrolled in
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$0,$4,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$0,$4,$2,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $0,$0,$4,$2,$2,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2,$2
	.word $0,$4,$2,$2,$2,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2
	.word $2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2,$2	
	
BG2Tilemap:
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8
	.word $1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4,$1,$2,$3,$4
	.word $5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8,$5,$6,$7,$8

