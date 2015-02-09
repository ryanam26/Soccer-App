class Role < EnumerateIt::Base
  associate_values(
    :admin   => [0, 'Administrator'],
    :coach  => [1, 'Coach'],
    :standard    => [2, 'Standard']
  )
end
