class Problem
  # Esercizio 3
  describe "#max_depth" do

    examples = [
      { input: nil, output: 0 },
      { input: 346, output: 0 },
      { input: 'slono', output: 0 },
      { input: [1,2,3], output: 1 },
      { input: [], output: 1 },
      { input: [[1],2,3], output: 2 },
      { input: [[],2,3], output: 2 },
      { input: [[[1],3],4], output: 3 }
    ]

    examples.each do |ex|
      context "when input = #{ex[:input].to_s}" do
        it "should return #{ex[:output].to_s}" do
          expect(Problem.max_depth(ex[:input])).to eq ex[:output]
        end
      end
    end
  end
end
