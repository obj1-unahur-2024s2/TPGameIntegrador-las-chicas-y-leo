import elementos.*
object pedido {

    const property miPedidoDeBarra = new PedidoDeBarra(position = game.origin())

}

class PedidoFantasma {

    const property fantasmaAsignado

    const property image = "pedidoCafe.png"

    const property position = game.at(fantasmaAsignado.position().x()+1,fantasmaAsignado.position().y()+1)

}

class PedidoDeBarra {

    const property image = "pedidoCafeBarra.png"
    
    var property position

    method encontrarLugarLibreEnBarra() {
        return barra.posiciones().find({p => not barra.posicionOcupada(p)})
    }

}