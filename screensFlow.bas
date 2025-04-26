Sub showMenu()
    stopMusicAndNirvana()
    inMenu = 1
    dzx0Standard(@titleScreen, $4000)
    
    ' Print At 0,0;"1 Keyboard"
    ' Print At 0,11;"2 Kempston"
    ' Print At 0,22;"3 Sinclair"
    
    Do
        If MultiKeys(KEY1) Then
            If Not keyArray(LEFT) Then
                Let keyArray(LEFT) = KEYO
                Let keyArray(RIGHT) = KEYP
                Let keyArray(UP) = KEYQ
                Let keyArray(DOWN) = KEYA
                Let keyArray(FIRE) = KEYSPACE
            End If
            playGame()
        Elseif MultiKeys(KEY2) Then
            kempston = 1
            playGame()
        Elseif MultiKeys(KEY3) Then
            Let keyArray(LEFT)=KEY6
            Let keyArray(RIGHT)=KEY7
            Let keyArray(UP)=KEY9
            Let keyArray(DOWN)=KEY8
            Let keyArray(FIRE)=KEY0
            playGame()
            #ifdef REDEFINE_KEYS_ENABLED
            Elseif MultiKeys(KEY4) Then
                redefineKeys()
            #endif
        End If
    Loop
End Sub

Sub playGame()
    Ink 7: Paper 0: Border 0: BRIGHT 0: FLASH 0: Cls
    NIRVANAstart()
    protaY = 160
    protaX = 2
    
    drawMap()
    musicStart()

    ' Print AT 0,0;"arriba"
    ' Print AT 22,0;"abajo"
    
    NIRVANAhalt()
    NIRVANAspriteT(PROTA_SPRITE, protaTile, protaY, protaX)
    
    Do
        waitretrace
        
        getCurrentSpritesPositions()
        keyboardListen()
        checkIdle()
        checkIsJumping()
        gravity()
        moveBullet()
        drawSprites()
    Loop
End Sub