#include <retrace.bas>
#include <keys.bas>
#include <zx0.bas>
#include "nirvana+.bas"
#include "output/maps.bas"
#include "definitions.bas"
#include "music.bas"
#include "functions.bas"
#include "draw.bas"
#include "protaMovement.bas"
#include "screensFlow.bas"

Dim inMenu As Ubyte = 0

NIRVANAtiles(@btiles)

load "" CODE ' Load vtplayer
load "" CODE ' Load music

showMenu()

btiles:
Asm
    incbin "assets/tiles.btile"
End Asm

titleScreen:
Asm
    incbin "output/title.png.scr.zx0"
End Asm
