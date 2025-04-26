Const LEFT As Ubyte = 0
Const RIGHT As Ubyte = 1
Const UP As Ubyte = 2
Const DOWN As Ubyte = 3
Const FIRE As Ubyte = 4

Dim currentLife As Ubyte = 100
Dim currentKeys As Ubyte = 0
Dim moveScreen As Ubyte
Dim currentScreen As Ubyte = 4
Dim currentBulletSpriteId As Ubyte

Dim protaFrame As Ubyte = 0
Dim enemFrame As Ubyte = 0

Dim kempston As Ubyte
Dim keyOption As String
Dim keyArray(4) As Uinteger

Dim framec As Ubyte AT 23672

Dim lastFrameProta As Ubyte = 0
Dim lastFrameProtaMovement As Ubyte = 0
Dim protaTile As Ubyte = 50

Dim protaY As Ubyte = 0
Dim protaX As Ubyte = 0

Const jumpStopValue As Ubyte = 255
Const jumpStepsCount As Ubyte = 5
Dim jumpCurrentKey As Ubyte = jumpStopValue
Dim jumpArray(jumpStepsCount - 1) As Byte = {-8, -8, -8, -8, -8}
Dim landed As Ubyte = 1

Dim protaSprite As Ubyte = 0
Dim protaDirection As Ubyte = 1
Dim protaDirectionChanged As Ubyte = 0

Const PROTA_ANIMATION_PERIOD As Ubyte = 4

