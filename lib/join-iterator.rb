def join_sorted(iterators)
  iterators = iterators.map(&:to_enum)
  values = []
  keys = []
  iterators.each_with_index do |iterator, index|
    begin
      kv = iterator.next
      values[index] = kv[1]
      keys[index] = kv[0]
    rescue StopIteration
      values[index] = nil
      keys[index] = nil
      iterators[index] = nil
    end
  end

  until iterators.map{|x| x == nil}.all?
    line = []
    min_key = keys.select{|x| x != nil }.min
    keys.each_with_index do |key, index| 
      if key == min_key
        line << values[index]

        begin
          kv = iterators[index].next
          values[index] = kv[1]
          keys[index] = kv[0]
        rescue StopIteration
          values[index] = nil
          keys[index] = nil
          iterators[index] = nil
        end
      else
        line << nil
      end
    end

    yield [min_key, line]
  end 
end
