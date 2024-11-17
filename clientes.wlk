import wollok.game.*
import configuracion.*
import elementos.*
import mozo.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {

    var property estoyVisible
  
    var property position = game.origin()

    var property image = "fa6.png"

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["fa1.png", "fa2.png","fa3.png","fa4.png","fa5.png"]

    const property miPedido = new Pedido(fantasmaAsignado=self)

    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        game.schedule(3000,{game.removeVisual(self) cliente.fantasmasVisibles().remove(self)})
        if (game.hasVisual(miPedido)) {
            game.removeVisual(miPedido)
        }
    }

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
        estoyVisible=true
        self.mostrarPedido()
    }

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method mostrarPedido() {
        game.schedule(6000,{game.addVisual(miPedido)})
    }

    method comunicarPedido() {}

    method recibirPedido() {}

    // method rechazarPedidoIncorrecto() {}

    method comer() {}

    method enojarse() {}

    method desenojarse() {}

}

object cliente {

    const property todosLosFantasmas = [unFantasma, otroFantasma, yOtroFantasma]
    const property fantasmasVisibles = []

    const fantasmasAtendidosCorrectamente = 0
    const fantasmasNoAtendidos = 0

    const property unFantasma = new Cliente(estoyVisible=false)
    const property otroFantasma = new Cliente(estoyVisible=false)
    const property yOtroFantasma = new Cliente(estoyVisible=false)

}

class Pedido {

    const property fantasmaAsignado

    const property image = "pedidoCafe.png"

    const property position = game.at(fantasmaAsignado.position().x()+1,fantasmaAsignado.position().y()+1)

}
