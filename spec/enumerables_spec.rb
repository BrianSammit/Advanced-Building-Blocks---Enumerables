require './enumerables'

describe Enumerable do
  let (:arr) { [1, 2, 3, 4] }
  let (:ans) { [] }
  let (:bool) { [true, false, nil] }
  let (:str) { %w[Dog Cat Mouse] }
  let (:my_hash) { { 'cat' => 0, 'dog' => 1, 'wombat' => 2} }

  context 'my_each' do
    it 'It goes through the array' do
      arr.my_each { |x| ans << x * 2 }
      expect(ans).to eql([2, 4, 6, 8])
    end

    it 'it goes through the str' do
      str.my_each { |x| ans << x }
      expect(ans).to eql(%w[Dog Cat Mouse])
    end

    it 'if no block is given, returns an enumerator' do
      expect(arr.my_each).to be_an Enumerator
    end
  end

  context 'my_each_with_index' do
    it 'It goes through the my_hash (value)' do
      my_hash.my_each_with_index { |key, value| ans << value.to_s }
      expect(ans).to eql(%w[0 1 2])
    end

    it 'It goes through the my_hash (value * 2)' do
      my_hash.my_each_with_index { |key, value| ans << (value * 2).to_s }
      expect(ans).to eql(%w[0 2 4])
    end

    it 'if no block is given, returns an enumerator' do
      expect(my_hash.my_each_with_index).to be_an Enumerator
    end
  end

  context 'my_select' do
    it 'It select the item with the condition given' do
      arr.my_select {|x| ans << x if x.even?}
      expect(ans).to eql([2, 4])
    end

    it 'if no block is given, returns an enumerator' do
      expect(arr.my_select).to be_an Enumerator
    end
  end

  context 'my_all?' do
    it 'It checks if all numbers are greater than 4 or not' do
      expect(arr.my_all? { |x| x > 4 }).to eql(false)
    end

    it 'It checks if all element inside the array are Numeric' do
      expect(arr.my_all?(Numeric)).to eql(true)
    end

    it 'It checks if all element inside the array are String' do
      expect(arr.my_all?(String)).to eql(false)
    end

    it 'It checks if all element has `o` ' do
      expect(str.my_all?(/o/)).to eql(false)
    end

    it 'It checks if the length of all element is less than 7 ' do
      expect(str.my_all? {|x| x.length < 7 }).to eql(true)
    end
  end
end
