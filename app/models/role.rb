class Role < EnumerateIt::Base
  associate_values(
    :Admin   => [0, 'Administrator'],
    :Coach  => [1, 'Coach'],
    :Player    => [2, 'Player']
  )
end
