import parte1.*

object mensajeria {
  const property mensajeros = [roberto, chuckNorris, neo] // property
  
  // method mensajeros() = mensajeros ("property" ya nos da su getter)
  method contratar(nuevoMensajero) {
    mensajeros.add(nuevoMensajero)
  }
  
  method despedir(unMensajero) {
    mensajeros.remove(unMensajero)
  }
  
  method purga() {
    mensajeros.clear()
  }
  
  method esGrande() = self.mensajeros().size() > 2
  
  method primeroEntrega(unPaquete) = self.mensajeros().first().puedeEntregar(
    unPaquete
  )
  
  method pesoUltimoMensajero() = self.mensajeros().last().peso()
}