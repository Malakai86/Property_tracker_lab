require('pry-byebug')
require_relative('models/property_order')

PropertyOrder.delete_all()

order1 = PropertyOrder.new(
 {
   "address" => "Fairfield Road",
   "value" => '100',
   "number_of_bedrooms" => '3',
   "year_built" => "1960"
 }
)

order1.save()

order2 = PropertyOrder.new(
  {
    "address" => "Drynie Terrace",
    "value" => '75',
    "number_of_bedrooms" => '2',
    "year_built" => '1945'
  }
)

order2.save()

binding.pry
nil
