import wollok.game.*

object mozo {

    method image() = "mozoPrueba.png"
    var property position = game.at(0,0)

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

}