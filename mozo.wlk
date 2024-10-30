import wollok.game.*

object mozo {

    method image() = "totoro-pixel.jpg"
    var property position = game.at(0,0)

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

}