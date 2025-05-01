import parte1.*
import parte2.*

object sistemaMensajeria {
  var facturacion = 0
  const paquetesPendientes = []
  const paquetesEnviados = []
  
  method facturacion() = facturacion
  
  method facturacion(unMonto) {
    facturacion += unMonto
  }
  
  method paquetesPendientes() = paquetesPendientes
  
  method paquetesEnviados() = paquetesEnviados
  
  method paqueteEntregable(unPaquete) = mensajeria.mensajeros().any(
    { x => x.puedeEntregar(unPaquete) }
  )
  
  method mensajerosAptos(unPaquete) = mensajeria.mensajeros().filter(
    { x => x.puedeEntregar(unPaquete) }
  )
  
  method tieneSobrepeso() = (mensajeria.mensajeros().map(
    { x => x.peso() }
  ).sum() / mensajeria.mensajeros().size()) > 500
  
  method enviarPaquete(unPaquete) {
    if (self.mensajerosAptos(unPaquete).size() > 0) self.mensajerosAptos(
        unPaquete
      ).anyOne().entregarPaquete(unPaquete)
    else paquetesPendientes.add(unPaquete)
  }
  
  method enviarPaquetes(listaPaquetes) {
    listaPaquetes.forEach({ x => x.serEntregado() })
  }
  
  method enviarElMasCaro() {
    if (self.paqueteEntregable(
      self.paquetesPendientes().max({ x => x.precio() })
    )) {
      self.enviarPaquete(self.paquetesPendientes().max({ x => x.precio() }))
      paquetesPendientes.remove(
        self.paquetesPendientes().max({ x => x.precio() })
      )
    }
  }
}

object paquetito {
  method estaPago() = true
  
  method destino() = [entregable]
  
  method precio() = 0
  
  method serEntregado() {
    sistemaMensajeria.enviarPaquete(self)
  }
}

object paquetonViajero {
  var montoPagado = 0
  const destino = [puenteBrooklyn, laMatrix, entregable]
  
  method montoPagado() = montoPagado
  
  method montoPagado(unMonto) {
    montoPagado = (montoPagado + unMonto).min(self.precio())
  }
  
  method destino() = destino
  
  method destino(destinos) {
    destino.addAll(destinos)
  }
  
  method precioDeterminado() = 50
  
  method precio() = self.precioDeterminado() + (self.destino().size() * 100)
  
  method estaPago() = self.montoPagado() == self.precio()
  
  method serEntregado() {
    sistemaMensajeria.enviarPaquete(self)
  }
}

object entregable {
  method requisito(mensajero) = true
}
//////////////////////Nuevos Objetos///////////////////////////////////////////////////////////////////////////////////

object rodrigo {
  method peso() = 120
  
  method puedeLlamar() = true
  
  method cumpleRequisito(paquete) = paquete.destino().requisito(self)
  
  method puedeIngresar(paquete) = paquete.destino().all(
    { x => x.requisito(self) }
  )
  
  // Self Check
  method puedeEntregar(paquete) = self.puedeIngresar(
    paquete
  ) and paquete.estaPago()
  
  method entregarPaquete(unPaquete) {
    sistemaMensajeria.facturacion(unPaquete.precio())
    sistemaMensajeria.paquetesEnviados().add(unPaquete)
  }
}

object paquetotote {
  var montoPagado = 0
  const destino = [puenteBrooklyn, laMatrix]
  
  method montoPagado() = montoPagado
  
  method montoPagado(unMonto) {
    montoPagado = (montoPagado + unMonto).min(self.precio())
  }
  
  method destino() = destino
  
  method destino(destinos) {
    destino.addAll(destinos)
  }
  
  method precioDeterminado() = 500
  
  method precio() = self.precioDeterminado() + (self.destino().size() * 150)
  
  method estaPago() = self.montoPagado() == self.precio()
  
  method serEntregado() {
    sistemaMensajeria.enviarPaquete(self)
  }
}