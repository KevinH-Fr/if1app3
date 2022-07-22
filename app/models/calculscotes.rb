class Calculscotes < ApplicationRecord
    attribute :my_string, :string
    attribute :my_int_array, :integer, array: true
    attribute :my_float_range, :float, range: true
  end
  
  model = Calculscotes.new(
    my_string: "string",
    my_int_array: ["1", "2", "3"],
    my_float_range: "[1,3.5]",
  )
  model.attributes
 