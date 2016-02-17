# ricorda: puoi usare la funzione `puts` per stampare del testo a video, per effettuare
# il debug pero' e' meglio usare la funzione `p`

# Rappresenta un punto in uno spazio di 2 dimensioni
class Point2D
  # costruisce un punto con coordinate (x,y)
  def initialize(x, y)
  end

  # la classe punto deve avere metodi getter per gli attributi `x` e `y`
  # NON deve invece avere metodi setter

  # la funzione `+` riceve come argomento un oggetto Point2D e restituisce un nuovo
  # oggetto Point2D che ha come coordinate la somma delle coordinate dei due oggetti.
  # (x1 + x2, y1 + y2)
  # NOTA: la funzione non deve alterare lo stato interno dell'oggetto
  def + (point)
    nil
  end

  # restituisce una rappresentazione testuale dell'oggetto punto, nella forma "(x,y)",
  # senza spazi.
  # ES: siano x = 1, y = 2.345, la funzione deve restituire "(1,2.345)"
  def to_s
    nil
  end
end
