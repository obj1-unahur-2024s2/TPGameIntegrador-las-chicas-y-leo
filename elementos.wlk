import wollok.game.*

// este script contiene TODOS los elementos visuales que aparecerán en nuestro videojuego

// DEFINICION DE CLASES PARA LOS OBJETOS A UTILIZAR
class ElementoSolido {

    // creamos una clase elemento solido que nos permita definir objetos
    // a los cuales no se los pueda "atravesar"

    const property position

    method esSolido() = true // verificar si se utiliza

}

class Silla inherits ElementoSolido {

    method image() = "celdaPrueba.png" // aún debemos hacer la imagen "silla"

}

class Mesa inherits ElementoSolido {
    // definir
}

class Barra inherits ElementoSolido {
    // definir
}

// CREACIÓN DE LOS OBJETOS A UTILIZAR

const todosLosElementosSolidos = [unaSilla]
// esta lista contendrá TODOS los objetos que añadiremos VISUALMENTE a la escena

const unaSilla = new Silla(position = game.at(3,3)) // por ahora, creamos una silla para realizar las pruebas
