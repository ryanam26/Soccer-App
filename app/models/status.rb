class Status < EnumerateIt::Base
  associate_values(
    :Inactive   => [0, 'Inactive'],
    :Active  => [1, 'Active']
  )
end
