Sub pauseUntilPressKey()
    Do
    Loop Until GetKeyScanCode()
End Sub

Function isPair(number As Ubyte) As Ubyte
    If number bAND 1 = 0 Then
        Return 1
    Else
        Return 0
    End If
End Function

Sub debugA(i As Ubyte)
    Print At 0, 0;"    "
    Print At 0, 0;i
End Sub

Sub debugB(i As Ubyte)
    Print At 0, 8;"    "
    Print At 0, 8;i
End Sub

Sub debugC(i As Ubyte)
    Print At 0, 16;"    "
    Print At 0, 16;i
End Sub

Sub debugD(i As Ubyte)
    Print At 0, 24;"    "
    Print At 0, 24;i
End Sub

Sub getCurrentSpritesPositions()
    protaY = Peek SPRITELIN(protaSprite)
    protaX = Peek SPRITECOL(protaSprite)
End Sub

Function getCell(row As Ubyte, col As Ubyte) As Ubyte
    Return screens(currentScreen, row, col) - 1
End Function

Function getCellByNirvanaPosition(lin As Ubyte, col As Ubyte) As Ubyte
    lin = (lin / 16) - 1
    col = col / 2
    
    Return getCell(lin, col)
End Function

Function isSolidTile(lin As Ubyte, col As Ubyte) As Ubyte
    Dim tile As Ubyte = getCell(lin, col)
    
    If tile = 1 Then Return 1
    If tile = 2 Then Return 1
    
    Return 0
End Function

Function isJumping() as Ubyte
    Return jumpCurrentKey <> jumpStopValue
End Function

Function CheckCollision(nextCol As Ubyte, nextLin As Ubyte) As Ubyte
    Dim currentLin As Ubyte = Peek SPRITELIN(protaSprite)
    Dim currentCol As Ubyte = Peek SPRITECOL(protaSprite)
    
    If nextCol = currentCol And nextLin = currentLin Then
        Return 0
    End If
    
    ' Convertir las coordenadas del sprite al sistema de tiles
    Dim tileRow As Ubyte = (nextLin / 16) - 1
    Dim tileCol As Ubyte = nextCol / 2
    
    ' Verificar el tile actual
    If isSolidTile(tileRow, tileCol) Then Return 1
    
    ' Verificar si cruza un límite horizontal
    If nextCol Mod 2 <> 0 Then
        If isSolidTile(tileRow, tileCol + 1) Then Return 1
    End If
    
    ' Verificar si cruza un límite vertical
    If nextLin Mod 16 <> 0 Then
        If isSolidTile(tileRow + 1, tileCol) Then Return 1
    End If
    
    ' Verificar si cruza ambos límites (esquina)
    If nextCol Mod 2 <> 0 And nextLin Mod 16 <> 0 Then
        If isSolidTile(tileRow + 1, tileCol + 1) Then Return 1
    End If
    
    
    Return 0
End Function

sub stopMusicAndNirvana()
    musicStop()
    NIRVANAstop()
    INK 7: PAPER 0: BORDER 0: BRIGHT 0: FLASH 0: CLS
end sub