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
    If isJumping() Or landed = 0 Then
        If protaDirection Then
            Return 58
        Else
            Return 59
        End If
    Else
        If protaDirection Then
            If Peek SPRITEVAL(PROTA_SPRITE) = 50 Then
                Return 51
            Elseif Peek SPRITEVAL(PROTA_SPRITE) = 51 Then
                Return 52
            Elseif Peek SPRITEVAL(PROTA_SPRITE) = 52 Then
                Return 53
            Else
                Return 50
            End If
        Else
            If Peek SPRITEVAL(PROTA_SPRITE) = 54 Then
                Return 55
            Elseif Peek SPRITEVAL(PROTA_SPRITE) = 55 Then
                Return 56
            Elseif Peek SPRITEVAL(PROTA_SPRITE) = 56 Then
                Return 57
            Else
                Return 54
            End If
        End If
    End If
End Function

Sub drawSprites()
    NIRVANAhalt()
    drawProta()
    NIRVANAhalt()
    drawBullet()
End Sub

Sub drawProta()
    ' If CheckCollision(protaX, protaY) Then Return
    
    Dim spriteLin As Ubyte = Peek SPRITELIN(PROTA_SPRITE)
    Dim spriteCol As Ubyte = Peek SPRITECOL(PROTA_SPRITE)
    Dim spriteTile As Ubyte = Peek SPRITEVAL(PROTA_SPRITE)
    
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
        NIRVANAfillT(0, spriteLin, spriteCol)
        NIRVANAspriteT(PROTA_SPRITE, spriteTile, protaY, protaX)
    End If
End Sub

Sub drawBullet()
    If bulletPositionX = 0 Then Return

    NIRVANAfillT(0, Peek SPRITELIN(BULLET_SPRITE), Peek SPRITECOL(BULLET_SPRITE))
    
    If bulletDirection = 1 Then
        NIRVANAspriteT(BULLET_SPRITE, BULLET_SPRITE_RIGHT_ID, bulletPositionY, bulletPositionX)
    Else
        NIRVANAspriteT(BULLET_SPRITE, BULLET_SPRITE_LEFT_ID, bulletPositionY, bulletPositionX)
    End If
End Sub