import wollok.game.*
import mozo.*
import clientes.*
import elementos.*
import niveles.*

// este script contiene la CONFIGURACIÓN de las teclas, colisiones, etc.

object config {

	method configurarTeclas() {

		keyboard.left().onPressDo( {mozo.irA((mozo.position().left(1))) mozo.image("fantasmaIZQUIERDA.png")} )
		keyboard.right().onPressDo( {mozo.irA(mozo.position().right(1)) mozo.image("fantasmaDERECHA.png")} )
		keyboard.up().onPressDo( {mozo.irA(mozo.position().up(1)) mozo.image("fantasmaESPALDA.png")} )
		keyboard.down().onPressDo( {mozo.irA(mozo.position().down(1)) mozo.image("fantasmaFRENTE.png")} )
		keyboard.t().onPressDo({cliente.fantasmasVisibles().forEach({fantasma => fantasma.desaparecer()})})
		keyboard.g().onPressDo({self.anadirDeAUnFantasma(self.tiempoAlAzar())})
		keyboard.p().onPressDo({game.addVisual(pantallaDerrota)})
		keyboard.m().onPressDo({ 

            if (mozo.hayFantasmaEnCeldaLindante() and game.hasVisual(mozo.elFantasmaLindante().miPedido())){
				mozo.quitarPedido() //elimnar burbuja
				//crear pedido
				//actualizar fantasma
            }

        })

    }

	method hayBorde(posicionAMover) {

		return posicionAMover.x() == 0 ||
		       posicionAMover.x() == 17||
			   posicionAMover.y() == 0 ||
			   posicionAMover.y() == 11
		// este método devuelve si la posición dada contiene alguno de los ejes donde se encuentra el borde de la escena

	}

	method hayColision(posicionAMover) {

		return elementoSolido.todosLosElementosSolidos().any({elemento => elemento.position() == posicionAMover or elemento.positionTwo() == posicionAMover}) || self.hayBorde(posicionAMover)
		// este método devuelve si algún elemento sólido de la escena es IGUAL a la posición dada
		// por ahora, lo utilizamos para sensar el movimiento del mozo,
		// si la posición a la que SE MOVERÁ el mozo es LA MISMA que la de algún elemento sólido de la escena
		// si es verdadero, entonces habrá colisión
	}

	method configurarColisiones() {

		//game.whenCollideDo(unaSilla, {mozo => mozo.irA(mozo.lastPosition())})
		// configuración que se utilizó de prueba, por ahora lo dejamos

	}

	method reproducirAnimacion(objetoAAnimar, listaDeAnimacion, nombreTick) {

        var indice = 0

        game.onTick(500,nombreTick,{
            objetoAAnimar.image(listaDeAnimacion.get(indice))
            indice += 1
            if (indice == listaDeAnimacion.size())
                game.removeTickEvent(nombreTick)
            })
	}

	method anadirDeAUnFantasma(unTiempo) {

		var indice = 0

		game.onTick(unTiempo,"anadir fantasma",{
			cliente.todosLosFantasmas().get(indice).aparecer()
			indice += 1
			if (indice == cliente.todosLosFantasmas().size())
				game.removeTickEvent("anadir fantasma")
		})
	}

	method tiempoAlAzar() {
		return 3000.randomUpTo(6000)
	}

}
