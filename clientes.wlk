import wollok.game.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
  
    const property position

    var property image = "f1.png"

    method aparecer() {
        
    }

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

    method reproducirAnimacion(elementoAAnimar) {

        var indice = 0

        game.onTick(500,"animacion",{
            elementoAAnimar.image(elementoAAnimar.animacion().get(indice))
            indice += 1
            if (indice == elementoAAnimar.animacion().size())
                game.removeTickEvent("animacion")
            })

    }

}

const fantasmasVisibles = [unFantasma]
const unFantasma = new Cliente(position = game.at(6,3))