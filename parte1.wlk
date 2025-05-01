import parte3.*

// PRIMERA PARTE
//MENSAJEROS
object roberto {
  const transportes = #{bicicleta, camion}
  var transporteActual = bicicleta
  
  method peso() = 90 + self.transporteActual().peso()
  
  method transportes() = transportes
  
  method transporteActual() = transporteActual
  
  method transporteActual(nuevoTransporte) {
    transporteActual = nuevoTransporte
  }
  
  method puedeLlamar() = false
  
  method cumpleRequisito(paquete) = paquete.destino().requisito(self)
  
  method puedeIngresar(paquete) = paquete.destino().all(
    { x => x.requisito(self) }
  )
  
  // Self check
  method puedeEntregar(paquete) = self.puedeIngresar(
    paquete
  ) and paquete.estaPago()
  
  method entregarPaquete(unPaquete) {
    sistemaMensajeria.facturacion(unPaquete.precio())
    sistemaMensajeria.paquetesEnviados().add(unPaquete)
  }
}

object chuckNorris {
  method peso() = 80
  
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

object neo {
  var credito = true //bool
  
  method credito() = credito
  
  method credito(unBool) {
    credito = unBool
  }
  
  method peso() = 0
  
  method puedeLlamar() = self.credito()
  
  method cumpleRequisito(paquete) = paquete.destino().requisito(self)
  
  method puedeIngresar(paquete) = paquete.destino().all(
    { x => x.requisito(self) }
  )
  
  // Self check
  method puedeEntregar(paquete) = self.puedeIngresar(
    paquete
  ) and paquete.estaPago()
  
  method entregarPaquete(unPaquete) {
    sistemaMensajeria.facturacion(unPaquete.precio())
    sistemaMensajeria.paquetesEnviados().add(unPaquete)
  }
}

object jose {
  method peso() = 80
  
  method puedeLlamar() = [true, false].anyOne()
  
  method cumpleRequisito(paquete) = paquete.destino().requisito(self)
  
  method puedeIngresar(paquete) = paquete.destino().all(
    { x => x.requisito(self) }
  )
  
  method entregarPaquete(unPaquete) {
    sistemaMensajeria.facturacion(unPaquete.precio())
    sistemaMensajeria.paquetesEnviados().add(unPaquete)
  }
} //PAQUETES

object paquete1 {
  method destino() = [puenteBrooklyn] // Ahora todos los destinos son listas
  
  method estaPago() = true
  
  method precio() = 75 // Parte 2
  
  method serEntregado() {
    sistemaMensajeria.enviarPaquete(self) // Parte 3
  }
}

object paquete2 {
  method destino() = [laMatrix] // Ahora todos los destinos son listas
  
  method estaPago() = true
  
  method precio() = 150 // Parte 2
  
  method serEntregado() {
    sistemaMensajeria.enviarPaquete(self) // Parte 3
  }
} //DESTINOS

object puenteBrooklyn {
  method requisito(unObjeto) = unObjeto.peso() <= 1000
}

object laMatrix {
  method requisito(unObjeto) = unObjeto.puedeLlamar()
} //VEHICULOS

object bicicleta {
  method peso() = 5
}

object camion {
  var cantAcoplados = 5
  
  method cantAcoplados() = cantAcoplados
  
  method pesoCamion() = 100
  
  method cantAcoplados(nuevosAcoplados) {
    cantAcoplados = nuevosAcoplados
  }
  
  method peso() = self.pesoCamion() + self.pesoAcoplados()
  
  method pesoAcoplados() = acoplado.peso() * self.cantAcoplados()
}

object acoplado {
  method peso() = 500
}