require('pg')
class PropertyOrder

  attr_accessor :address, :value, :number_of_bedrooms, :year_built

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
  end

def save()
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "INSERT INTO property_orders (
  address,
  value,
  number_of_bedrooms,
  year_built
  ) VALUES (
    $1,
    $2,
    $3,
    $4
    )
    RETURNING *"
values = [@address, @value, @number_of_bedrooms, @year_built]
db.prepare("save", sql)
@id = db.exec_prepared("save", values)[0]['id'].to_i
db.close()
end

def delete()
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "DELETE FROM property_orders WHERE id = $1"
  values = [@id]
  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close()
end

def update()
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "UPDATE property_orders SET(
  address,
  values,
  number_of_bedrooms,
  year_built
  ) = (
    $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@address, @values, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

def PropertyOrder.all()
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "SELECT * FROM property_orders"
  db.prepare("all", sql)
  orders = db.exec_prepared("all")
  db.close()
  return orders.map {|order| PropertyOrder.new(order)}
end

def PropertyOrder.delete_all()
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "DELETE FROM property_orders"
  db.prepare("delete_all", sql)
  db.exec_prepared('delete_all')
  db.close()
end

def PropertyOrder.find_by_id(id)
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "SELECT * FROM property_orders WHERE id = $1"
  values = [id]
  db.prepare("find_by_id", sql)
  order_data = db.exec_prepared('find_by_id', values)[0]
  order = PropertyOrder.new(order_data)
  db.close()
  return order
end


end
