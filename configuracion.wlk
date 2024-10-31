import wollok.game.*
import mozo.*
import elementos.*

// este script contiene la CONFIGURACIÓN de las teclas, colisiones, etc.

object config {

	method configurarTeclas() {

		keyboard.left().onPressDo( {mozo.irA((mozo.position().left(1)))} )
		keyboard.right().onPressDo( {mozo.irA(mozo.position().right(1))} )
		keyboard.up().onPressDo( {mozo.irA(mozo.position().up(1))} )
		keyboard.down().onPressDo( {mozo.irA(mozo.position().down(1))} )

    }

	method hayBorde(posicionAMover) {

		return posicionAMover == game.at(0,posicionAMover.y()) ||
		       posicionAMover == game.at(17,posicionAMover.y()) ||
			   posicionAMover == game.at(posicionAMover.x(),0) ||
			   posicionAMover == game.at(posicionAMover.x(),11)
		// este método devuelve si la posición dada contiene alguno de los ejes donde se encuentra el borde de la escena

	}

	method hayColision(posicionAMover) {

		return todosLosElementosSolidos.any({elemento => elemento.position() == posicionAMover}) || self.hayBorde(posicionAMover)
		// este método devuelve si algún elemento sólido de la escena es IGUAL a la posición dada
		// por ahora, lo utilizamos para sensar el movimiento del mozo,
		// si la posición a la que SE MOVERÁ el mozo es LA MISMA que la de algún elemento sólido de la escena
		// si es verdadero, entonces habrá colisión
	}

	method configurarColisiones() {

		game.whenCollideDo(unaSilla, {mozo => mozo.irA(mozo.lastPosition())})
		// configuración que se utilizó de prueba, por ahora lo dejamos

	}

}