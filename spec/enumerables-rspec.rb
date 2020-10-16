require '../enumerables'

describe Enumerable do
  let (:arr) { [1, 2, 3, 4] }
  let (:ans) { [] }
  let (:bool) { [true, false, nil] }
  let (:str) { %w[Dog Cat Mouse] }

  context 'my_each' do
    it 'It goes through the array' do
      arr.my_each {|x| ans << x * 2 }
      expect(ans).to eql([2, 4, 6, 8])
    end

    it 'it goes through the str' do
      str.my_each {|x| ans << x}
      expect(ans).to eql(%w[Dog Cat Mouse] )
    end

    it 'if no block is given, returns an enumerator' do
      expect(arr.my_each).to be_an Enumerator
    end
  end

  context 'my_each_with_index' do
    it 'It goes through the array and index' do
      arr.my_each_with_index {|x, y| ans << x => y }
      expect(ans).to eql([1=>0, 2=>1, 3=>2, 4=>3])
    end
  end
  
end