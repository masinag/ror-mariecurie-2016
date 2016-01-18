Istruzioni
===

0. Installa RSpec (solo la prima volta): `gem install rspec`
1. Copia `exercise.rb` e `exercise_spec.rb` nella stessa directory
2. Riempi i metodi in `exercise.rb` come richiesto nel commento
3. Esegui `rspec -c exercise_spec.rb`
4. Se tutto è corretto vedrai `20 examples, 0 failures`. I test rossi indicano i tuoi errori.

**Suggerimento:** esegui `rspec -c exercise_spec.rb` anche prima di aver completato tutti gli esercizi

Come si legge il risultato di un test?
---

Quando un test fallisce. RSpec ritorna una cosa del genere:

```
1) welcome_message should return "Hello, World!"
   Failure/Error: expect(welcome_message).to eq "Hello, World!"

     expected: "Hello, World!"
          got: "Pippo è Pelato"

     (compared using ==)
   # ./exercise_spec.rb:5:in `block (2 levels) in <top (required)>'
```
Vuol dire che il metodo `welcome_message` ha ritornato "Pippo è Pelato" anziché "Hello, World!"

Oppure

```
4) factorial when input = 2 should eq 2
   Failure/Error: it { expect(factorial 2).to eq (1*2) }

     expected: 2
          got: 16

     (compared using ==)
   # ./exercise_spec.rb:17:in `block (3 levels) in <top (required)>'
```

Vuol dire che con input 2 ci si aspettava 2 e invece il metodo ha ritornato 16.
