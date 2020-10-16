# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ShadowingOuterLocalVariable
# rubocop:disable Metrics/DoubleNegation
# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each()
    converted_array = to_a
    n = converted_array.length
    i = 0
    return to_enum unless block_given?

    while i < n
      yield converted_array[i]
      i += 1
    end

    self
  end

  def my_each_with_index()
    converted_array = to_a
    n = converted_array.length
    i = 0

    return to_enum unless block_given?

    while i < n
      yield converted_array[i], i
      i += 1
    end

    self
  end

  def my_select()
    converted_array = to_a
    i = 0
    returned_array = []
    return to_enum unless block_given?

    while i < converted_array.length
      conditional_met = yield converted_array[i]
      returned_array.push(converted_array[i]) if conditional_met == true
      i += 1
    end
    returned_array
  end

  def my_all?(*args)
    if args.empty?
      if block_given?
        my_each { |i| return false unless yield(i) }
      else
        my_each { |i| return false unless i }
      end
    else
      raise ArgumentError, 'Too many arguments, Expected 1!' if args.length > 1

      puts 'Warning: given block not used' if block_given?

      if args[0].is_a?(Class)
        my_each { |i| return false unless i.is_a?(args[0]) }
      elsif args[0].is_a?(Regexp)
        my_each { |i| return false unless i.match(args[0]) }
      else
        my_each { |i| return false unless i == args[0] }
      end
    end
    true
  end

  def my_any?(*arg)
    if arg.empty?
      if block_given?
        my_each { |i| return true if yield(i) == true }
      else
        my_each { |i| return true if i }
      end
    else
      raise ArgumentError, 'Too many arguments, Expected 1!' if arg.length > 1

      puts 'Warning: given block not used' if block_given?

      if arg[0].is_a?(Class)
        my_each { |i| return true if i.is_a?(arg[0]) }
      elsif arg[0].is_a?(Regexp)
        my_each { |i| return true if i.match(arg[0]) }
      else
        my_each { |i| return true if i == arg[0] }
      end
    end
    false
  end

  def my_none?(*arg)
    if arg.empty?
      if block_given?
        my_each { |i| return false if yield(i) == true }
      else
        my_each { |i| return false if i == true }
      end
    else
      raise ArgumentError, 'Too many arguments, Expected 1!' if arg.length > 1

      puts 'Warning: given block not used' if block_given?

      if arg[0].is_a?(Class)
        my_each { |i| return false if i.is_a?(arg[0]) }
      elsif arg[0].is_a?(Regexp)
        my_each { |i| return false if i.match(arg[0]) }
      else
        my_each { |i| return false if i == arg[0] }
      end
    end
    true
  end

  def my_count(optional_parameter = nil)
    converted_array = to_a
    n = converted_array.length
    i = 0
    condition_met_counter = 0
    if optional_parameter
      converted_array.each do |i|
        condition_met_counter += 1 if i == optional_parameter
      end
      return condition_met_counter
    end
    return n unless block_given?

    while i < n
      returned_flag = yield converted_array[i]
      condition_met_counter += 1 if returned_flag
      i += 1
    end
    condition_met_counter
  end

  def my_map(proc = nil)
    converted_array = to_a
    n = converted_array.length
    i = 0
    retun_array = []
    if proc.nil?
      return to_enum unless block_given?

      while i < n
        returned_value = yield converted_array[i]
        retun_array.push(returned_value)
        i += 1
      end
    else
      while i < n
        returned_value = proc.call(converted_array[i])
        retun_array.push(returned_value)
        i += 1
      end
    end
    retun_array
  end

  def my_inject(*argu)
    raise LocalJumpError, 'no block given' if !block_given? && argu.empty?

    converted_array = to_a
    n = converted_array.length
    i = 0
    memo = 0
    if !!argu[0] && !!argu[1]
      pp 'The block will be ignored' if block_given?
      argu[1] = argu[1].to_sym
      memo = converted_array.my_inject(argu[0]) { |sum, n| sum.method(argu[1]).call(n) }
      return memo
    end
    unless block_given?
      return 'no-block no-argument ----> ERROR' unless argu[0]
      unless argu[0].class.to_s == 'String' || argu[0].class.to_s == 'Symbol'
        return 'When no-block, argument should be a binary operation symbol'
      end

      argu[0] = argu[0].to_sym
      memo = converted_array.my_inject { |sum, n| sum.method(argu[0]).call(n) }
      return memo
    end
    if !!argu[0]
      unless argu[0].is_a?(Numeric)
        return 'Block is given && only one argument is provided ----> argu[0] must be a numeric value'
      end

      memo = argu[0]
    else
      memo = converted_array[i]
      i = 1
    end
    while i < n
      memo = yield memo, converted_array[i]
      i += 1
    end
    memo
  end
end

def multiply_els(arr)
  arr = arr.to_a
  memo = arr.my_inject { |sum, n| sum * n }
  memo
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ShadowingOuterLocalVariable
# rubocop:enable Metrics/DoubleNegation
# rubocop:enable Metrics/ModuleLength
