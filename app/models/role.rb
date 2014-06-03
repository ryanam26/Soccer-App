class Role < EnumerateIt::Base
  associate_values(
    :admin   => [0, 'Administrator'],
    :coach  => [1, 'Coach'],
    :player    => [2, 'Player']
  )
end
