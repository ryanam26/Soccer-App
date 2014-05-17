class Unit < EnumerateIt::Base
  associate_values(
    :Time   => [0, 'Time'],
    :Numeric  => [1, 'Numeric']
  )
end
