require './exercise.rb'

describe Point2D do
  let(:x) { 1.0 }
  let(:y) { 2.0 }
  let(:point) { Point2D.new(x,y) }

  it 'should have attribute accessors for x and y' do
    expect(point).to respond_to(:x, :y)
    expect(point.x).to eq x
    expect(point.y).to eq y
  end

  it 'should not have attribute writers for x and y' do
    expect(point).not_to respond_to(:x=, :y=)
  end

  it 'should have a `+` method' do
    point1 = point + point
    expect(point1.x).to eq(x + x)
    expect(point1.y).to eq(y + y)
  end

  it 'should not change state when using the `+` method' do
    point + point
    expect(point.x).to eq x
    expect(point.y).to eq y
  end

  it 'should have a to_s method' do
    expect(point.to_s).to eq "(#{x},#{y})"
  end
end

