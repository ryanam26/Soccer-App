class Level < EnumerateIt::Base
  associate_values(
    :Beginner   => [0, 'Beginner'],
    :Intermediate  => [1, 'Intermediate'],
    :Advanced    => [2, 'Advanced'],
    :NotApplicable    => [3, 'Not Applicable']
  )
end
