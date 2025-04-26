Sub keyboardListen()
    If kempston Then
        Dim n As Ubyte = In(31)
        If n bAND %10 Then leftKey()
        If n bAND %1 Then rightKey()
        If n bAND %1000 Then upKey()
        If n bAND %100 Then downKey()
        If n bAND %10000 Then fireKey()
        #ifdef IDLE_ENABLED
            If n = 0 Then
                If protaLoopCounter < IDLE_TIME Then protaLoopCounter = protaLoopCounter + 1
            Else
                protaLoopCounter = 0
            End If
        #endif
    Else
        If MultiKeys(keyArray(LEFT))<>0 Then leftKey()
        If MultiKeys(keyArray(RIGHT))<>0 Then rightKey()
        If MultiKeys(keyArray(UP))<>0 Then upKey()
        If MultiKeys(keyArray(DOWN))<>0 Then downKey()
        If MultiKeys(keyArray(FIRE))<>0 Then fireKey()
    End If
End Sub

Sub leftKey()
    If protaDirection = 1 Then
        protaDirectionChanged = 1
    End If
    protaDirection = 0

    If CheckCollision(protaX - 1, protaY) Then return

    If protaX > 0 Then
        protaX = protaX - 1
    Else
        protaX = 30
    End If
End Sub
Sub rightKey()
    If protaDirection = 0 Then
        protaDirectionChanged = 1
    End If
    protaDirection = 1

    If CheckCollision(protaX + 1, protaY) Then return

    If protaX < 29 Then
        protaX = protaX + 1
    Else
        protaX = 0
        landed = 0
    End If
End Sub
Sub upKey()
    jump()
End Sub
Sub downKey()
    ' If protaY < 192 Then
    '     protaY = protaY + 2
    ' End If
End Sub
Sub fireKey()
End Sub

Sub gravity()
    If isJumping() Then Return

    Dim currentCol As Ubyte = Peek SPRITECOL(protaSprite)
    Dim currentLin As Ubyte = Peek SPRITELIN(protaSprite)

    If CheckCollision(protaX, protaY + 2) Then
        landed = 1
        Return
    End If

    If protaY < 168 Then
        protaY = protaY + 8
    Else
        protaY = 0
    End If
End Sub

Sub jump()
    If jumpCurrentKey = jumpStopValue and landed Then
        landed = 0
        jumpCurrentKey = 0
    End If
End Sub

Sub checkIsJumping()
    If jumpCurrentKey = jumpStopValue Then Return
    
    If protaY < 2 Then
        protaY = 160
    Elseif jumpCurrentKey < jumpStepsCount
        jumpCurrentKey = jumpCurrentKey + 1
        If CheckCollision(protaX, protaY - 2) Then Return
        protaY = protaY + jumpArray(jumpCurrentKey)
    Else
        jumpCurrentKey = jumpStopValue ' stop jumping
    End If
End Sub