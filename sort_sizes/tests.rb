require 'minitest/autorun'

require_relative 'sort_sizes'

class SortSizesTest < Minitest::Test
  def setup
    @sorted_array = %w[XXS XS S M L XL XXL XS/P S/P M/P L/P XL/P]
  end

  def test_empty_array_given
    assert_equal [], sort_sizes([])
  end

  def test_sort_one_full_array
    shuffled_array = @sorted_array.shuffle
    assert_equal @sorted_array, sort_sizes(shuffled_array)
  end

  def test_uncomplete_array_1
    sorted_array = %w[XXS XS S M L XL XXL]
    shuffled_array = sorted_array.shuffle
    assert_equal sorted_array, sort_sizes(shuffled_array)
  end

  def test_uncomplete_array_2
    sorted_array = %w[XS S M L XL XS/P S/P M/P L/P XL/P]
    shuffled_array = sorted_array.shuffle
    assert_equal sorted_array, sort_sizes(shuffled_array)
  end

  def test_duplicate_values
    sorted_array = %w[XS XS S S M M M L XL XL XXL]
    shuffled_array = sorted_array.shuffle
    assert_equal sorted_array, sort_sizes(shuffled_array)
  end

  def test_mix_case_values
    shuffled_array = %w[xS s xL l]
    assert_raises ArgumentError do
      sort_sizes(shuffled_array)
    end
  end

  def test_invalid_sizes_given
    shuffled_array = %w[L M S foo bar]
    assert_raises ArgumentError do
      sort_sizes(shuffled_array)
    end
  end
end

class SortNumericSizesTest < Minitest::Test
  def setup
    @sorted_array = %w[000 00 0 2 4 6 8 10 12 14]
  end

  def test_random_array
    shuffled_array = @sorted_array.shuffle
    assert_equal @sorted_array, sort_numeric_sizes(shuffled_array)
  end

  def test_uncomplete_array_1
    shuffled_array = %w[0 2 8 6 4 000 00]
    sorted_array = %w[000 00 0 2 4 6 8]
    assert_equal sorted_array, sort_numeric_sizes(shuffled_array)
  end

  def test_uncomplete_array_2
    shuffled_array = %w[00 12 6 14 4 000 2 8 10 0]
    sorted_array = %w[000 00 0 2 4 6 8 10 12 14]
    assert_equal sorted_array, sort_numeric_sizes(shuffled_array)
  end
end
