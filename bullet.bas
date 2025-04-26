Sub moveBullet()
    If bulletPositionX = 0 Then Return
    
    If bulletDirection = 1 Then
        If bulletPositionX >= bulletEndPositionX Then
            resetBullet()
            Return
        Else If CheckCollision(bulletPositionX + BULLET_SPEED, bulletPositionY) Then
            resetBullet()
            Return
        End If
        bulletPositionX = bulletPositionX + BULLET_SPEED
    Elseif bulletDirection = 0 Then
        If bulletPositionX <= bulletEndPositionX Then
            resetBullet()
            Return
        Else If CheckCollision(bulletPositionX - BULLET_SPEED, bulletPositionY) Then
            resetBullet()
            Return
        End If
        bulletPositionX = bulletPositionX - BULLET_SPEED
    End If
End Sub

Sub resetBullet()
    NIRVANAhalt()
    NIRVANAspriteT(BULLET_SPRITE, 0, Peek SPRITELIN(BULLET_SPRITE), Peek SPRITECOL(BULLET_SPRITE))
    bulletPositionX = 0
    bulletPositionY = 0
    bulletDirection = 0
End Sub