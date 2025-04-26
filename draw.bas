Const screenHeight As Ubyte = 11
Const screenWidth As Ubyte = 16
Const screenCount As Ubyte = 2
Dim cell As Ubyte = 0
Dim drawing As Ubyte = 0

Sub drawMap()
    Dim counter As Ubyte = 0
    For row=0 To screenHeight - 1
        For col=0 To screenWidth - 1
            Dim cell As Ubyte = getCell(row, col)
            counter = counter + 1
            If cell = 0 Then
                NIRVANAfillT(0, (row + 1) * 16, col * 2)
            Else
                NIRVANAdrawT(cell, (row + 1) * 16, col * 2)
            End If
        Next col
    Next row
End Sub

Function getNextProtaFrame(currentTile As Ubyte) As Ubyte
    If isJumping() or landed = 0 Then
        If protaDirection Then
            Return 58
        Else
            Return 59
        End If
    Else
        If protaDirection Then
            If Peek SPRITEVAL(protaSprite) = 50 Then
                Return 51
            Elseif Peek SPRITEVAL(protaSprite) = 51 Then
                Return 52
            Elseif Peek SPRITEVAL(protaSprite) = 52 Then
                Return 53
            Else
                Return 50
            End If
        Else
            If Peek SPRITEVAL(protaSprite) = 54 Then
                Return 55
            Elseif Peek SPRITEVAL(protaSprite) = 55 Then
                Return 56
            Elseif Peek SPRITEVAL(protaSprite) = 56 Then
                Return 57
            Else
                Return 54
            End If
        End If
    End If
End Function

Sub drawSprites()
    ' If CheckCollision(protaX, protaY) Then Return
    
    Dim spriteLin As Ubyte = Peek SPRITELIN(protaSprite)
    Dim spriteCol As Ubyte = Peek SPRITECOL(protaSprite)
    Dim spriteTile As Ubyte = Peek SPRITEVAL(protaSprite) 
    
    If protaY <> spriteLin Or protaX <> spriteCol Or spriteTile = 58 Or spriteTile = 59 Then
        If protaDirectionChanged Then
            spriteTile = getNextProtaFrame(spriteTile)
            protaDirectionChanged = 0
        Else
            If framec - lastFrameProta >= PROTA_ANIMATION_PERIOD Then
                spriteTile = getNextProtaFrame(spriteTile)
                lastFrameProta = framec
            End If
        End If
        NIRVANAhalt()
        NIRVANAfillT(0, Peek SPRITELIN(protaSprite), Peek SPRITECOL(protaSprite))
        NIRVANAspriteT(protaSprite, spriteTile, protaY, protaX)
    End If
End Sub