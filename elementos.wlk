import wollok.game.*
import clientes.*

// este script contiene TODOS los elementos visuales que aparecerán en nuestro videojuego

// DEFINICION DE CLASES PARA LOS OBJETOS A UTILIZAR
class ElementoSolido {

    // creamos una clase elemento solido que nos permita definir objetos
    // a los cuales no se los pueda "atravesar"

    method positionTwo() {return position}
    const property position

    method esSolido() = true // verificar si se utiliza

}

class SillaIzq inherits ElementoSolido {

    method orientacion() = "izquierda"

    method estaOcupada() {
        return cliente.fantasmasVisibles().any({f => f.position() == self.position()})
    }

    method image() = "restauranteSillaIzquierda.png" // aún debemos hacer la imagen "silla"

}
class SillaDer inherits ElementoSolido {

    method orientacion() = "derecha"

    method estaOcupada() {
        return cliente.fantasmasVisibles().any({f => f.position() == self.position()})
    }

    method image() = "restauranteSillaDerecha.png" // aún debemos hacer la imagen "silla"

}
class Mesa inherits ElementoSolido {
    // definir
    method image() = "restauranteMesa.png"

    override method positionTwo() {
        return game.at(self.position().x()+1, self.position().y())
    }
}

object barra {
    
    method position() = game.at(1, 9)

    method posiciones() = [game.at(2, 9), game.at(3, 9), game.at(4, 9), game.at(5, 9), game.at(6, 9), game.at(7, 9), game.at(8, 9), game.at(9, 9)]

    method image() = "unaBarra.png"

    method hayBarra(unaPosicion) {
        return self.posiciones().any({p => p == unaPosicion})
    }

    method posicionOcupada(unaPosicion) {
        return not game.getObjectsIn(unaPosicion).isEmpty()
    }

    method positionTwo() {return self.position()}

}

object elementoSolido {

    // CREACIÓN DE LOS OBJETOS A UTILIZAR

    const property todosLosElementosSolidos = [sillaDer1, sillaIzq1, mesa1, sillaDer2, sillaIzq2, mesa2, sillaDer3, sillaIzq3, mesa3,
                                    sillaDer4, sillaIzq4, mesa4, sillaDer5, sillaIzq5, mesa5, barra]
    // esta lista contendrá TODOS los objetos que añadiremos VISUALMENTE a la escena

    // lista posiciones sillas
    const property posicionesSillas = todasLasSillas.map({s => s.position()})

    const property todasLasSillas = [sillaDer1, sillaIzq1, sillaDer2, sillaIzq2,
    sillaDer3, sillaIzq3, sillaDer4, sillaIzq4,
    sillaDer5, sillaIzq5]

    // MESA 1
    const sillaDer1 = new SillaIzq(position = game.at(3,3))
    const sillaIzq1 = new SillaDer(position = game.at(6,3))
    const mesa1 = new Mesa(position = game.at(4,3))

    // MESA 2
    const sillaDer2 = new SillaIzq(position = game.at(11,3))
    const sillaIzq2 = new SillaDer(position = game.at(14,3))
    const mesa2 = new Mesa(position = game.at(12,3))

    // MESA 3
    const sillaDer3 = new SillaIzq(position = game.at(7,5))
    const sillaIzq3 = new SillaDer(position = game.at(10,5))
    const mesa3 = new Mesa(position = game.at(8,5))

    // MESA 4
    const sillaDer4 = new SillaIzq(position = game.at(3,7))
    const sillaIzq4 = new SillaDer(position = game.at(6,7))
    const mesa4 = new Mesa(position = game.at(4,7))

    // MESA 5
    const sillaDer5 = new SillaIzq(position = game.at(11,7))
    const sillaIzq5 = new SillaDer(position = game.at(14,7))
    const mesa5 = new Mesa(position = game.at(12,7))

}