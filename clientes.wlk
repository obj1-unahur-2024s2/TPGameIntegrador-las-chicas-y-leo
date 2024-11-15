import wollok.game.*
import configuracion.*
import elementos.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
  
    const property position

    var property image = "f6.png"

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["f1.png", "f2.png","f3.png","f4.png","f5.png"]

    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        game.schedule(3000,{game.removeVisual(self)})
    }

    method aparecer() {
        config.sumarFantasma()
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
    }

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

const fantasmasVisibles = [unFantasma, otroFantasma, yOtroFantasma]
const unFantasma = new Cliente(position = posicionesSillas.anyOne())
const otroFantasma = new Cliente(position = posicionesSillas.anyOne())
const yOtroFantasma = new Cliente(position = posicionesSillas.anyOne())