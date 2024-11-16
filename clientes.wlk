import wollok.game.*
import configuracion.*
import elementos.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
  
    var property position = game.origin()

    var property image = "f6.png"

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["f1.png", "f2.png","f3.png","f4.png","f5.png"]


    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        game.schedule(3000,{game.removeVisual(self) cliente.fantasmasVisibles().remove(self)})
    }

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
    }

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method solicitarMozo() {}
    // método que solicita al mozo para pensar el pedido

    method pensarPedido() {}

    method comunicarPedido() {}

    method recibirPedido() {}

    // method rechazarPedidoIncorrecto() {}

    method comer() {}

    method enojarse() {}

    method desenojarse() {}



    /*
    method desaparecer() {

        const animacion = ["f2.png","f3.png","f4.png","f5.png","f6.png"]
        var indice = 0
    
        game.onTick(500, "animacion", {
            self.image(animacion.get(indice))
            indice += 1
            if (indice == animacion.size())
                game.removeTickEvent("animacion")
            })

    }

    method reproducirAnimacion(objetoAAnimar, listaDeAnimacion) {

        var indice = 0

        game.onTick(500,"animacion",{
            objetoAAnimar.image(listaDeAnimacion.get(indice))
            indice += 1
            if (indice == listaDeAnimacion.size())
                game.removeTickEvent("animacion")
            })

    }
    */

}

object cliente {

    const property todosLosFantasmas = [unFantasma, otroFantasma, yOtroFantasma]
    const property fantasmasVisibles = []

    const fantasmasAtendidosCorrectamente = 0
    const fantasmasNoAtendidos = 0

    const unFantasma = new Cliente()
    const otroFantasma = new Cliente()
    const yOtroFantasma = new Cliente()

}