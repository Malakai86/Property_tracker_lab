DROP TABLE IF EXISTS property_orders;

CREATE TABLE property_orders(
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  number_of_bedrooms INT,
  year_built INT
);
