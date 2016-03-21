describe Problem do
  # Esercizio 2
  describe "#min_uppercase" do

    examples = [
      { input: [], output: nil },
      { input: [''], output: '' },
      { input: ['aa', 'bb'], output: 'aa' },
      { input: ['AA', 'BB'], output: 'AA' },
      { input: ['AA', 'AB', 'Af'], output: 'Af' },
      { input: ['AA', 'AB', 'aa', 'ab'], output: 'aa' }
    ]

    examples.each do |ex|
      context "when input = #{ex[:input].to_s}" do
        it "should return #{ex[:output].to_s}" do
          expect(Problem.min_uppercase(ex[:input])).to eq ex[:output]
        end
      end
    end

  end
end
