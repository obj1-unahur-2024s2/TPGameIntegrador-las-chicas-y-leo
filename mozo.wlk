import niveles.*
import wollok.game.*
import configuracion.*
import clientes.*

// este script contiene el modelo del MOZO, nuestro personaje principal

object mozo {

	var clientesPerdidos = 0

	var property image = "fantasmaFRENTE.png"

	method image(unaImagen) {
		image = unaImagen
	}

    var position = game.at(1,1) // posicion inicial que irá variando con el movimiento
	// var lastPosition = position // la posicion ANTERIOR a la actual en la que se encontraba el mozo (verificar si se usa)

	method position() = position // getter

	// method lastPosition() = position // getter

	method celdasLindantes() = [self.position().left(1),
							   self.position().right(1),
							   self.position().up(1),
							   self.position().down(1)]

	method perderCliente() {
		clientesPerdidos += 1
		if (clientesPerdidos == 3)
			game.addVisual(pantallaDerrota)
	}

	//method image() = "mozoPrueba.png" // imagen de prueba

	method irA(nuevaPosicion) {

		if (not config.hayColision(nuevaPosicion)) {
			// se verifica que en la posición a moverse NO se genere una colisión entre el mozo y un elemento sólido

			// lastPosition = position // antes de moverse, se guarda la posición actual (que luego de moverse será la ANTERIOR)
			position = nuevaPosicion // se actualiza la posición
			
			}

		else {position = self.position()} // si hay una colisión, el mozo se queda en la posición actual
	}

	method hayFantasmaEnCeldaLindante() {

		return self.celdasLindantes().any({c => self.hayFantasma(c)})

	}

	method hayFantasma(unaPosicion) {

		return cliente.fantasmasVisibles().any({f=>f.position() == unaPosicion})

	}

	method posicionDelFantasmaLindante() = self.celdasLindantes().find({c => self.hayFantasma(c)})

	method elFantasmaLindante() = game.getObjectsIn(self.posicionDelFantasmaLindante()).get(1)

	method quitarPedido(){
		//if(self.hayFantasmaEnCeldaLindante()){
			//const hola = self.celdasLindantes().find({c => self.hayFantasma(c)}) // cambiar nombre
			//const hola2 = game.getObjectsIn(hola) // cambiar nombre
			//game.removeVisual(hola2.get(1).miPedido())
			game.removeVisual(self.elFantasmaLindante().miPedido())
		//}
	} 

	/*method tomarPedido() {
		keyboard.x().onPressDo({ 

            if (self.hayFantasmaEnCeldaLindante() and game.hasVisual(self.elFantasmaLindante().miPedido())){
				self.quitarPedido()
				//crear pedido
				//actualizar fantasma
            }

        })	  
	}*/

	method atenderClienteParaQuePiense() {}

	method atenderPedido() {}

	method tomarPlatoDeBarra() {}

	method servirPlato() {}

}