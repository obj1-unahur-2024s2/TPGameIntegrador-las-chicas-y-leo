import wollok.game.*
import mozo.*
import clientes.*
import elementos.*
import niveles.*
import pedidos.*


// este script contiene la CONFIGURACIÓN de las teclas, colisiones, etc.

object config {

	method configurarTeclas() {

		keyboard.left().onPressDo( {mozo.irA((mozo.position().left(1))) mozo.image(mozo.mostrarImagenIzquierda())} )
		keyboard.right().onPressDo( {mozo.irA(mozo.position().right(1)) mozo.image(mozo.mostrarImagenDerecha())} )
		keyboard.up().onPressDo( {mozo.irA(mozo.position().up(1)) mozo.image(mozo.mostrarImagenEspalda())} )
		keyboard.down().onPressDo( {mozo.irA(mozo.position().down(1)) mozo.image(mozo.mostrarImagenFrente())} )
		keyboard.t().onPressDo({cliente.fantasmasVisibles().forEach({fantasma => fantasma.desaparecer()})})
		keyboard.g().onPressDo({self.anadirDeAUnFantasma(self.tiempoAlAzar())})
		keyboard.p().onPressDo({game.addVisual(pantallaDerrota)})
		keyboard.x().onPressDo({ 

            if (mozo.hayFantasmaParaTomarPedido()){ //cuando el mozo el tomo el pedido al cliente
				mozo.quitarPedido() //elimnar burbuja
				//const pepe = new PedidoDeBarra(position = game.origin())
				mozo.crearPedidoEnBarra(new PedidoDeBarra(position = game.origin()))//crear pedido
				mozo.elFantasmaLindante().tienePedidoEnCurso(true)
				mozo.elFantasmaLindante().reiniciar()
				//actualizar cliente, el tiempo
            }

        })
		keyboard.m().onPressDo({ //cuando el mozo el toma el pedido de la barra

            if (mozo.hayPedidoEnBarraParaTomar() /* and el mozo tiene el visual del mozo con cafe*/){
				//cambiar el visual al mozo
				mozo.tieneCafeEnMano(true)
				mozo.borrarPedidoEnBarra()
				mozo.actualizarImagenMozoAConCafe()
			}

        })
		keyboard.l().onPressDo({ //cuando el mozo ya agarro el pedido de la barra

            if (mozo.puedeDejarPedido() /* and el mozo tiene el visual del mozo con cafe*/){
				mozo.tieneCafeEnMano(false)
				mozo.ponerPedidoEnMesa()
				mozo.actualizarImagenMozoASinCafe()
				mozo.elFantasmaLindante().tienePedidoEnCurso(false)
				mozo.elFantasmaLindante().recibirPedido()
				//cambiar el visual al mozo
				//poner el pedido en la mesa al lado del fantasma
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

		return elementoSolido.todosLosElementosSolidos().any({elemento => elemento.position() == posicionAMover}) || self.hayBorde(posicionAMover) || barra.hayBarra(posicionAMover)
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
