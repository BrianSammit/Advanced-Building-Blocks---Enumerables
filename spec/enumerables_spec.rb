require './enumerables'

describe Enumerable do
  let (:arr) { [1, 2, 3, 4] }
  let (:ans) { [] }
  let (:bool) { [true, false, nil] }
  let (:str) { %w[Dog Cat Mouse] }
  let (:str1) { ['Dog', 'Cat', 1, 3, 'Mouse', 4]}
  let (:my_hash) { { 'cat' => 0, 'dog' => 1, 'wombat' => 2 } }

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
      my_hash.my_each_with_index { |_key, value| ans << value.to_s }
      expect(ans).to eql(%w[0 1 2])
    end

    it 'It goes through the my_hash (value * 2)' do
      my_hash.my_each_with_index { |_key, value| ans << (value * 2).to_s }
      expect(ans).to eql(%w[0 2 4])
    end

    it 'if no block is given, returns an enumerator' do
      expect(my_hash.my_each_with_index).to be_an Enumerator
    end
  end

  context 'my_select' do
    it 'It select the item with the condition given' do
      arr.my_select { |x| ans << x if x.even?}
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

  context 'my_any?' do
    it 'It checks if any number are greater than 4 or not' do
      expect(arr.my_any? { |x| x > 4 }).to eql(false)
    end

    it 'It checks if any element inside the array are Numeric' do
      expect(str1.my_any?(Numeric)).to eql(true)
    end

    it 'It checks if all element inside the array are String' do
      expect(str1.my_any?(String)).to eql(true)
    end

    it 'It checks if any element has `o` ' do
      expect(str.my_any?(/o/)).to eql(true)
    end

    it 'It checks if the length of any element is less than 4 ' do
      expect(str.my_any? { |x| x.length < 4 }).to eql(true)
    end

    it 'It checks if one of the element is nil' do
      expect(bool.my_any? { |x| x == nil? }).to eql(true)
    end
  end

  context 'my_none' do
    it 'It checks if none of the numbers are greater than 4 or not' do
      expect(arr.my_none? { |x| x > 4 }).to eql(true)
    end

    it 'It checks if none of the elements inside the array are Numeric' do
      expect(str1.my_none?(Numeric)).to eql(false)
    end

    it 'It checks if none of the elements inside the array are String' do
      expect(str1.my_none?(String)).to eql(false)
    end

    it 'It checks if none of the elements has `o` ' do
      expect(str.my_none?(/o/)).to eql(false)
    end

    it 'It checks if the length of none of the element is less than 7 ' do
      expect(str.my_none? { |x| x.length < 7 }).to eql(false)
    end

    it 'It checks if none of the elements is nil' do
      expect(bool.my_none? { |x| x == nil? }).to eql(false)
    end
  end

  context 'my_count' do
    it 'It returns the number of items in the array' do
      expect(arr.my_count).to eql(4)
    end

    it 'It returns the number of items that match the condition' do
      expect(arr.my_count(2)).to eql(1)
    end

    it 'It return the number that match the block given' do
      expect(arr.my_count { |x| (x % 2).zero? }).to eql(2)
    end
  end

  context 'my_map' do
    it 'It return all element converted to upcase' do
      str.my_map { |s| ans << s.upcase }
      expect(ans).to eql(%w[DOG CAT MOUSE])
    end

    it 'Doubling numbers' do
      arr.my_map { |n| ans << n * 2 }
      expect(ans).to eql([2, 4, 6, 8])
    end

    it 'Converts hash keys to symbols' do
      my_hash.my_map { |k, v| ans << [k.to_sym, v] }
      expect(ans).to eql([[:cat, 0], [:dog, 1], [:wombat, 2]])
    end

    it 'Converts array of strings to array of symbols' do
      str.my_map { |s| ans << s.to_sym}
      expect(ans).to eql([:Dog, :Cat, :Mouse])
    end
  end

  context 'my_inject' do
    it 'It checks if the sum of the array is equal to 10' do
      expect(arr.my_inject { |sum, n| sum + n }).to eql(10)
    end

    it 'It checks if the multiply of the array is equal to 24' do
      expect(arr.my_inject(1) { |product, n| product * n }).to eql(24)
    end

    it 'it checks the longest wornd in the array' do
      expect(str.my_inject { |memo, word|
        memo.length > word.length ? memo : word } ).to eql('Mouse')
    end

    it 'Combines all elements of enum by applying a binary operation' do
      operation = proc { |sum, n| sum + n }
      ans = arr.my_inject(&operation)
      expect(ans).to eql(10)
    end

    it 'Multiplies when * Symbol is specified without an initial value' do
      expect(arr.my_inject(:*)).to eql(24)
    end

    it 'Add when + Symbol is specified within an initial value' do
      expect(arr.my_inject(20, :+)).to eql(30)
    end
  end

  context 'multiply_els' do
    it 'Multiplies all the elements of the array together' do
      ans = multiply_els arr
      expect(ans).to eql(24)
    end
  end
end
