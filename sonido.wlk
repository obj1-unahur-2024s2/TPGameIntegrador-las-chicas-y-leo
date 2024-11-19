import wollok.game.*

object quieroCafe {
  const property audio = game.sound("quieroCafe.mp3")

  method iniciarAudio(){
    audio.play()
    audio.volume(0.5)
  }
}

object musica {
  const property cancion = game.sound("musicaGhost.mp3")

  method iniciarCancion(){
    cancion.play()
    cancion.shouldLoop(true)
    cancion.volume(0.3)
  }
}