SIZES_KEY = %w[XXS XS S M L XL XXL XS/P S/P M/P L/P XL/P]
NUMERIC_SIZES_KEY = %w[000 00 0 2 4 6 8 10 12 14]

def sort(arr, key)
  raise ArgumentError.new('Invalid sizes') unless
    arr.all? { |size| key.include? size }

  arr.sort_by { |size| key.index(size) }
end

def sort_sizes(arr)
  sort(arr, SIZES_KEY)
end

def sort_numeric_sizes(arr)
  sort(arr, NUMERIC_SIZES_KEY)
end
