.segment "BANK1"

SPCPrg:
	.incbin ".\sound\sound.bin"
SPCPrgEnd:

SPC_LENGTH = SPCPrgEnd-SPCPrg
NUM_SPC_BLOCKS = (SPC_LENGTH / 256) + 1
copyAddr = $0 ;address to copy to (word)
copyIndex = $2 ;index within one block (byte)
blockIndex = $3 ;what block's being copied (byte)
kick = $4 ;current "kick" val

LoadSPC:
	php
	a16
	lda #NUM_SPC_BLOCKS
	lda #$200
	sta copyAddr ;set up copy address
	stz blockIndex
	a8
	lda #$cc ;starting kick val
	sta kick

WaitForInit:
	lda $2140
	cmp #$aa ;spc sets reg 0 to aa after it inits
	bne WaitForInit
	
CopyLoop:
	a16
	lda copyAddr
	sta $2142 ;write destination address
	clc
	adc #$100
	sta copyAddr
	a8
	
	lda #$1
	sta $2141 ;write command
	lda kick
	sta $2140 ;"enable"
WaitForAck: ;spc returns kick when it's ready to write
	lda $2140
	cmp kick
	bne WaitForAck
	
CopyBlock: ;copies blocks of 256 bytes 
	a16
	lda copyIndex ;because blockIndex is next to copyIndex in memory hopefully
	tax	;this will get the address (look at me, so smart for making blocks 256 bytes)
	a8
	lda f:SPCPrg,x ;specify bank
	sta $2141
	lda copyIndex
	sta $2140
	
WaitReceive:
	cmp $2140 ;spc mirrors count after receiving data
	bne WaitReceive
	inc a
	sta copyIndex
	cmp #$00 ;256 bytes in a block
	bne CopyBlock
	
	inc blockIndex
	lda kick
	clc
	adc #$2
	and #$7f ;kick=previous kick "+2 to 127" -ninty
	sta kick
	lda blockIndex
	cmp #NUM_SPC_BLOCKS
	bne CopyLoop
	
	a16
	lda #$200 ;entry point
	sta $2142
	a8
	stz $2141 ;start command
	lda kick
	sta $2140
	ldx #$6
@ClrLoop:
	stz $0,x
	dex
	bne @ClrLoop
	plp
	rtl
