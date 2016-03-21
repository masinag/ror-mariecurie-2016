class User
  # esercizio 1
  attr_accessor :email, :name, :surname, :sign_in_count, :registration_date

  # requisiti perche' un utente sia considerato valido:
  # email, name, surname deve essere una stringa non vuota
  # sign_in_count deve essere un Fixnum (intero) non negativo
  # registration_date deve essere un oggetto Date
  def valid?
  end

  # restituisce un vettore di simboli.
  # Se l'oggetto e' valido, restituisce un vettore vuoto
  # Se non lo e', per ogni attributo che non e' valido, la chiave per
  # quell'attributo deve essere presente nel vettore, in qualsiasi ordine.
  # esempio: email e name non sono validi, restituisce [:email, :name]
  def errors
  end
end

# Puoi testare manualmente il comportamento della classe User
require 'date'
u = User.new
u.email = 'user@example.com'
u.name = 'User'
u.surname = 'Surname'
u.sign_in_count = 12
u.registration_date = Date.new(2011,2,4)
#p u.valid?
#p u.errors

class ProblemA
  # esercizio 2
  # dato in input un vettore di oggetti, restituisce la somma di tutti gli
  # oggetti di classe Fixnum. Se non ci sono interi all'interno del vettore,
  # restituisce 0
  def self.sum_fixnums(input)
  end
end

#p ProblemA.sum_fixnums([]) # => 0
#p ProblemA.sum_fixnums([1]) # => 1
#p ProblemA.sum_fixnums([1,2,3,'stella']) # => 6
#p ProblemA.sum_fixnums([[1],2,3,'stella']) # => 5

class ProblemB
  # esercizio 3
  # dato in input un vettore di stringhe, restituisce la lunghezza della
  # stringa di lunghezza massima. Se il vettore e' vuoto, restituisce 0
  def self.max_length(input)
  end
end

#p ProblemB.max_length([]) # => 0
#p ProblemB.max_length(['a','bb','ccc']) # => 3
#p ProblemB.max_length(['a','b']) # => 1
#p ProblemB.max_length(['a']) # => 1