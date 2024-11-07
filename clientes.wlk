import wollok.game.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
  
    const property position

    var property image = "f1.png"

    method aparecer() {
        
    }

    method desaparecer() {

        const animacion = ["f2.png","f3.png","f4.png","f5.png","f6.png"]
        //animacion.forEach({imagen => game.onTick("1000", "animacion", self.image(imagen))})
        game.onTick(1000, "animacion", {self.image(animacion.anyOne())})
        //animacion.get(1)
        game.schedule(5000,{game.removeTickEvent("animacion")})

    }

}

const fantasmasVisibles = [unFantasma]
const unFantasma = new Cliente(position = game.at(6,3))