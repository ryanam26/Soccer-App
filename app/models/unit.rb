class Unit < EnumerateIt::Base
  associate_values(
    :time   => [0, 'Time'],
    :numeric  => [1, 'Numeric']
  )
end
