# ricorda: puoi usare la funzione `puts` per stampare del testo a video, per effettuare
# il debug pero' e' meglio usare la funzione `p`

# esercizio 1
# Rappresenta un punto in uno spazio di 2 dimensioni
class Point2D
  # costruisce un punto con coordinate (x,y)
  # nota che non e' necessario nessun controllo sul tipo di x e y
  def initialize(x, y)
    nil
  end

  # la classe punto deve avere metodi getter per gli attributi `x` e `y`
  # NON deve invece avere metodi setter

  # la funzione `+` riceve come argomento un oggetto Point2D e restituisce un
  # nuovo oggetto Point2D che ha come coordinate la somma delle coordinate dei
  # due oggetti. (x1 + x2, y1 + y2)
  # la funzione non deve alterare lo stato interno dell'oggetto, ma restituire
  # un nuovo oggetto
  def + (point)
    nil
  end

  # restituisce una rappresentazione testuale dell'oggetto punto, nella forma
  # "(x,y)", senza spazi.
  # ES: siano x = 1, y = 2.345, la funzione deve restituire "(1,2.345)"
  def to_s
    nil
  end
end

# puoi testare il comportamento di Point2D scrivendo codice qui sotto
p1 = Point2D.new(0,0)
#p p1.to_s

# esercizio 2
class Book
  attr_accessor :title, :author, :release_date, :publisher, :isbn

  # requisiti perche' un libro sia considerato valido:
  # title deve essere una stringa (@title.class == String) non vuota
  # author deve essere una stringa non vuota
  # release_date deve essere un oggetto Date
  # publisher deve essere una stringa non vuota
  # isbn deve essere un numero minore di 10**10 e maggiore di 0
  def valid?
    nil
  end

  # restituisce un vettore di simboli.
  # Se l'oggetto e' valido, restituisce un vettore vuoto
  # Se non lo e', per ogni attributo che non e' valido, la chiave per
  # quell'attributo deve essere presente nel vettore, in qualsiasi ordine.
  # esempio: title e author non sono validi, restituisce [:title, :author]
  def errors
    nil
  end
end

require 'date' # necessario per l'uso della classe Date
b = Book.new
b.title = 'Giulio Cesare'
b.author = 'Shakespeare'
b.release_date = Date.new(1599,1,1)
b.publisher = 'Tascabili Economici Newton'
b.isbn = 8879839934
#p b.valid?
#p b.errors.empty?

# esercizio 3
class Problem
  # duck typing
  # dato in input un oggetto, restituisce true se e' un oggetto di classe
  # vettore con elementi oggetti tutti di classe String o Fixnum; o se il
  # vettore e' vuoto.
  # restituisce false altrimenti
  def self.algorithm(input)
  end
end

#p Problem.algorithm([1,2,3,4,'5','67'])
#p Problem.algorithm([1,2,3,4,'5', 5.5])
#p Problem.algorithm([])
