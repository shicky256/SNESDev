.segment "CODE"

PLAYER_ACCEL = $4000 ;0.25 px
PLAYER_JUMP_SPEED = $fff8 ;-7
GRAVITY = $6fff ;~0.4px


MAX_PLAYER_SPEED = $3
MAX_SLOPE_SPEED = $4
PLAYER_STILL_TILE = $0
FIRST_PLAYER_TILE = $2
LAST_PLAYER_TILE = $8 ;horizontally
PLAYER_JUMPING_TILE = $E
PLAYER_TIMER_VAL = $6 ;animation timer
GROUND = $B0

PLAYER_RIGHT_ATTRS = %00110000
PLAYER_LEFT_ATTRS =  %01110000

PLAYER_WIDTH = $10
PLAYER_HEIGHT = $20
PLAYER_TOP = $9 ;offset from y pos to top of sprite

.enum
STATE_DECEL
STATE_RIGHT_HELD 
STATE_LEFT_HELD
.endenum

.enum
MOVE_STATE_NORMAL
MOVE_STATE_JUMPING
MOVE_STATE_FALLING ;like jumping but without the jumping frame
MOVE_STATE_SLOPE ;when player is on slope
.endenum

.enum
ANIM_MODE_ADD
ANIM_MODE_SUBTRACT
.endenum	

InitPlayer:
	php
	a8
	lda #GROUND
	sta playerY+2
	lda #$20
	sta playerX+2
	sta playerSpriteX
	lda #PLAYER_RIGHT_ATTRS
	sta playerAttrs
	lda #FIRST_PLAYER_TILE
	sta playerTileNum
	plp
	rts

HandlePlayerMovement:
	php
	a16
	lda joypad 
	bit #KEY_RIGHT ;sets up player state based on joypad input
	beq NotRight
		lda #STATE_RIGHT_HELD
		sta playerState
		a8
		lda #PLAYER_RIGHT_ATTRS
		sta playerAttrs
		a16
		jmp EndStateAssign
	NotRight:
	bit #KEY_LEFT
	beq NotLeft
		lda #STATE_LEFT_HELD
		sta playerState
		a8
		lda #PLAYER_LEFT_ATTRS
		sta playerAttrs
		a16
		jmp EndStateAssign
	NotLeft:
	lda #STATE_DECEL
	sta playerState
	
	EndStateAssign:
	
	lda playerState
	bne ModifySpeed
		jmp Released
	ModifySpeed:
	cmp #STATE_RIGHT_HELD
	bne RightNotHeld
		lda playerXSpeed+2		;if player speed is greater than max speed, don't apply acceleration
		cmp #MAX_PLAYER_SPEED
		bmi @AccelPlayer
			jmp AddSpeed
		@AccelPlayer:
			lda playerXSpeed
			clc
			adc #PLAYER_ACCEL
			sta playerXSpeed
			lda playerXSpeed+2
			adc #$0
			sta playerXSpeed+2
			jmp AddSpeed
	RightNotHeld:
	cmp #STATE_LEFT_HELD
	bne LeftNotHeld
		lda playerXSpeed+2
		cmp #-(MAX_PLAYER_SPEED)
		bpl @AccelPlayer
			jmp AddSpeed
		@AccelPlayer:
			lda playerXSpeed
			sec
			sbc #PLAYER_ACCEL
			sta playerXSpeed
			lda playerXSpeed+2
			sbc #$0
			sta playerXSpeed+2
			jmp AddSpeed
	LeftNotHeld:
	 
	Released:
	lda playerXSpeed
	bne PlayerMoving
	lda playerXSpeed+2
	bne PlayerMoving
	jmp PlayerStill
	PlayerMoving:
		lda playerXSpeed+2
		and #$8000
		beq DecelRight
			lda playerXSpeed ;going left, add speed until 0
			clc
			adc #PLAYER_ACCEL
			sta playerXSpeed
			lda playerXSpeed+2
			adc #$0
			sta playerXSpeed+2
			and #$8000
			bne @NotBelowZero
				stz playerXSpeed
				stz playerXSpeed+2
		@NotBelowZero:	
			jmp AddSpeed
		DecelRight:
			lda playerXSpeed
			sec
			sbc #PLAYER_ACCEL
			sta playerXSpeed
			lda playerXSpeed+2
			sbc #$0
			sta playerXSpeed+2
			and #$8000
			beq @NotBelowZero
				stz playerXSpeed
				stz playerXSpeed+2
			@NotBelowZero:
		
	AddSpeed:
	dec playerAnimTimer
	lda playerX
	clc
	adc playerXSpeed
	sta playerX
	lda playerX+2
	adc playerXSpeed+2
	sta playerX+2
	
	lda playerXSpeed+2
	and #$8000
	beq CheckRightCollision
		jsr HandleXCollisionL ;going left
		jmp EndCheckCollision
	CheckRightCollision:
		jsr HandleXCollisionR
	EndCheckCollision:
	jmp EndModifySpeed
	
	PlayerStill:	
	a8 ;if not pressing any buttons, reset tile and animation timer
	lda #PLAYER_STILL_TILE
	sta playerTileNum
	lda #PLAYER_TIMER_VAL
	sta playerAnimTimer
	lda #ANIM_MODE_ADD
	sta playerAnimMode
	a16
	EndModifySpeed:
	
	lda movementState ;eject vertically to the next tile when walking off a slope
	cmp #MOVE_STATE_SLOPE
	bne @NotOnSlope
		jsr CheckYCollisionD ;if on a non-slope tile and was on a slope
		beq @NotOnSlope
		tax
		lda TileAttrs, x
		bne @NotOnSlope
			lda #MOVE_STATE_NORMAL
			sta movementState
			@EjectLoop: ;vertical eject
				dec playerY+2
				jsr CheckYCollisionD
				beq @NotOnSlope
				tax
				lda TileAttrs, x
				bne @NotOnSlope
			bra @EjectLoop
	@NotOnSlope:
	
	lda movementState
	cmp #MOVE_STATE_JUMPING
	beq OnGround
	cmp #MOVE_STATE_FALLING
	beq OnGround
		jsr CheckYCollisionD
		beq StartFall
			tax
			lda TileAttrs, x
			bne SlopeInsertLoop
		bra OnGround
			SlopeInsertLoop: ;if on a slope tile, insert into ground until touching a non-slope tile
				inc playerY+2
				jsr CheckYCollisionD
				tax
				lda TileAttrs, x
				beq OnGround
			bra SlopeInsertLoop 
		StartFall:	
			lda #MOVE_STATE_FALLING
			sta movementState
	OnGround:
	jsr HandleSlopeCollision
	
	lda joypad
	bit #KEY_B
	beq DontStartJump
	lda joypadBuf ;if holding down B from last jump, don't start jumping again
	bit #KEY_B
	bne NotRising
		lda movementState
		cmp #MOVE_STATE_JUMPING
		beq NotRising ;don't want player jumping in air
		cmp #MOVE_STATE_FALLING
		beq NotRising
			lda #MOVE_STATE_JUMPING
			sta movementState
			lda #PLAYER_JUMP_SPEED
			sta playerYSpeed+2
			jmp NotRising
			; dec playerY+2
	DontStartJump:	
	lda playerYSpeed+2
	and #$8000
	beq NotRising ;if player is rising and let go of jump button, add a big ass number to speed to make them
		lda playerYSpeed ;fall faster
		clc
		adc #$B000
		sta playerYSpeed
		lda playerYSpeed+2
		adc #$0
		sta playerYSpeed+2
	NotRising:
	
	
	lda movementState
	cmp #MOVE_STATE_JUMPING
	beq Jumping
	cmp #MOVE_STATE_FALLING
	beq Jumping
	jmp NotJumping
	Jumping:
		lda playerYSpeed
		clc
		adc #GRAVITY
		sta playerYSpeed
		lda playerYSpeed+2
		adc #$0
		sta playerYSpeed+2
		lda playerY
		clc
		adc playerYSpeed
		sta playerY
		lda playerY+2
		adc playerYSpeed+2
		sta playerY+2
		UEjectLoop:
		jsr CheckYCollisionU
		beq NoCollisionU
			stz playerYSpeed
			stz playerYSpeed+2
			inc playerY+2
			jmp UEjectLoop
		NoCollisionU:
		lda playerYSpeed+2 ;if player isn't falling, don't check down collision
		and #$8000
		bne NotJumping
		jsr HandleYCollisionD
	NotJumping:
	
	lda movementState
	cmp #MOVE_STATE_JUMPING
	bne NoJumpingSprite ;switch to jumping sprite when jumping
		lda #PLAYER_JUMPING_TILE
		sta playerTileNum
		jmp DoneAnim
	NoJumpingSprite:
	
	a8
	lda playerAnimTimer ;is timer zero?
	bne DoneAnim
		lda #PLAYER_TIMER_VAL
		sta playerAnimTimer
		lda playerAnimMode
		bne AnimSubtract
			lda playerTileNum ;add to tile nim
			ina
			ina
			sta playerTileNum
			cmp #LAST_PLAYER_TILE ;if up to last tile, go to subtract mode
			bne DoneAnim
				lda #ANIM_MODE_SUBTRACT
				sta playerAnimMode
				jmp DoneAnim
		AnimSubtract: ;subtract from tile num
			lda playerTileNum
			dea
			dea
			sta playerTileNum
			cmp #FIRST_PLAYER_TILE
			bne DoneAnim
				lda #ANIM_MODE_ADD
				sta playerAnimMode
	DoneAnim:
	
	a16
	plp
	rts
	
HandleXCollisionL:
	lda movementState ;no wall collision if on slope
	cmp #MOVE_STATE_SLOPE
	beq NoCollisionL
		jsr CheckXCollisionL
		beq NoCollisionL
		tax
		lda TileAttrs, x ;tile attributes table in tiles.asm
		bne NoCollisionL ;non-zero: "soft" tile
			stz playerXSpeed
			stz playerXSpeed+2
			inc playerX+2
			bra HandleXCollisionL
	NoCollisionL:
	rts

HandleXCollisionR:
	lda movementState
	cmp #MOVE_STATE_SLOPE
	beq NoCollisionR
		jsr CheckXCollisionR
		beq NoCollisionR
		tax
		lda TileAttrs, x ;tile attributes table in tiles.asm
		bne NoCollisionR ;non-zero: "soft" tile
			stz playerXSpeed
			stz playerXSpeed+2
			dec playerX+2
			bra HandleXCollisionR
	NoCollisionR:	
	rts


HandleYCollisionD:
	jsr CheckYCollisionD ;0 = sprite in air
	beq NotInGround

	; tax
	; lda TileAttrs, x
	; beq NormalEject
	; jmp HandleSlopeCollision
	NormalEject:
		stz playerYSpeed 
		stz playerYSpeed+2
		stz playerY
		lda #MOVE_STATE_NORMAL
		sta movementState
		a8
		lda #PLAYER_STILL_TILE
		sta playerTileNum
		lda #PLAYER_TIMER_VAL
		sta playerAnimTimer
		lda #ANIM_MODE_ADD
		sta playerAnimMode
		a16
		YEjectLoop:
			dec playerY+2
			jsr CheckYCollisionD
			beq EjectedFromGround
			tax ;don't eject from ground if it's a slope tile
			lda TileAttrs, x
			bne EjectedFromGround
		bra YEjectLoop
		EjectedFromGround:
			inc playerY+2
	NotInGround:
	rts
	
	;playerY = ((playerY + PLAYER_HEIGHT-1) & $FFF0) - (tileLut, (middle of sprite x & $F)) - $10
HandleSlopeCollision:
	lda movementState
	cmp #MOVE_STATE_JUMPING
	beq NotOnSlope
	jsr CheckCollisionC
	tax
	lda TileAttrs, x
	beq NotOnSlope
		sta $4 ;location of height LUT for that block
		lda playerBGTile
		and #$4000 
		bne SubXCalc
			lda $0 ;x value of middle of sprite
			and #$000f
			asl ;words->bytes
			tay
			bra EndXCalc
		SubXCalc:
			lda $0 ;x value of middle of sprite
			and #$000f
			sta $0
			lda #$f ;if it's been mirrored, start looking at height LUT from the end of the tile
			sec
			sbc $0
			asl ;words->bytes
			tay
		EndXCalc:
		lda ($4), y
		sta $0 ;value to bump up y position by
		lda $2 ;tile where sprite's feet are
		and #$fff0
		sec
		sbc $0
		sec
		sbc #$10
		sta playerY+2
		lda #MOVE_STATE_SLOPE
		sta movementState
		
		lda playerBGTile
		and #$4000 ;has tile been mirrored?
		beq @SubtractMomentum
			lda playerXSpeed
			clc
			adc MomentumTable, x
			sta playerXSpeed
			lda playerXSpeed+2
			adc #$0
			cmp #MAX_SLOPE_SPEED
			bne @DontCapAddSpeed
				stz playerXSpeed
			@DontCapAddSpeed:
			sta playerXSpeed+2
			bra NotOnSlope
		@SubtractMomentum:
			lda playerXSpeed
			sec
			sbc MomentumTable, x
			sta playerXSpeed
			lda playerXSpeed+2
			sbc #$0
			cmp #-(MAX_SLOPE_SPEED+1)
			bne @DontCapSubSpeed
				lda #$ffff
				sta playerXSpeed
				lda #-(MAX_SLOPE_SPEED+1)
			@DontCapSubSpeed:
			sta playerXSpeed+2
	NotOnSlope:
	rts
	
CheckXCollisionL: ;for when player is moving left
	lda playerX+2
	sta $0
	lda playerY+2
	clc
	adc #PLAYER_HEIGHT-1
	sta $2
	jmp CheckPlayerCollision

CheckXCollisionR: ;when player is moving right
	lda playerX+2
	clc
	adc #PLAYER_WIDTH
	sta $0
	lda playerY+2
	clc
	adc #PLAYER_HEIGHT-1
	sta $2
	jmp CheckPlayerCollision

;center collision -> left collision -> right collision	
CheckYCollisionD:
	lda playerX+2 ;1. check for bottom-center collision
	clc
	adc #PLAYER_WIDTH/2
	sta $0
	lda playerY+2
	clc
	adc #PLAYER_HEIGHT+1
	sta $2
	jsr CheckPlayerCollision
	bne @EndCheck ;if center hard collision, exit routine
	
	lda playerX+2 ;2. check for bottom-left collision
	sta $0
	jsr CheckPlayerCollision
	bne @EndCheck
	
	lda playerX+2 ;3. check for bottom-right collision
	clc
	adc #PLAYER_WIDTH
	sta $0
	jsr CheckPlayerCollision
	@EndCheck:
	rts

CheckYCollisionU: ;when player is moving up
	lda playerX+2 ;1. check for bottom-center collision
	clc
	adc #PLAYER_WIDTH/2
	sta $0
	lda playerY+2
	clc
	adc #PLAYER_TOP+2
	sta $2
	jsr CheckPlayerCollision
	bne @EndCheck ;if center collision, exit routine
	
	lda playerX+2 ;2. check for bottom-left collision
	sta $0
	jsr CheckPlayerCollision
	bne @EndCheck
	
	lda playerX+2 ;3. check for bottom-right collision
	clc
	adc #PLAYER_WIDTH
	sta $0
	jsr CheckPlayerCollision
	@EndCheck:
	rts
	
CheckCollisionC: ;look at the center of the bottom of the player
	lda playerX+2
	clc
	adc #(PLAYER_WIDTH/2)
	sta $0
	lda playerY+2
	clc
	adc #PLAYER_HEIGHT-1
	sta $2
	
CheckPlayerCollision:
	lda $0 ;divide by 16
	and #$1ff
	lsr
	lsr
	lsr
	lsr
	sta playerBGTile
	lda $2 ;dividing y tile by 16 and then multiplying by 32 since tilemap's 32x32
	clc
	adc scrollY
	and #$fff0	  ;is the same as removing last nibble and shifting left once
	rol
	clc
	adc playerBGTile
	rol ;words->bytes
	tax
	lda TilemapMirror, x
	pha
	and #$43ff ;just get the 9 bit tile number and the x flip bit
	sta playerBGTile
	pla
	and #$3ff
	rts
	