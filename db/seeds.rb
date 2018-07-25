# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Shop.destroy_all
Merchant.destroy_all

merchant_1 = Merchant.create!({
    name: 'Bundaberg',
    email: 'merchant@bundaberg.com',
    password: 'Bundaberg1',
})

shop_1 = Shop.create!({
    merchant_fk: merchant_1.pk,
    name: 'Bundaberg Bottled Drinks',
    subdomain: 'bunda-bottles',
})

Product.create!({
    shop_fk: shop_1.pk,
    name: 'Ginger Beer',
    price: 7.99,
})

Product.create!({
    shop_fk: shop_1.pk,
    name: 'Root Beer',
    price: 5.99,
})

p "Created #{Merchant.count} merchant(s)!"
p "Created #{Shop.count} shop(s)!"
p "Created #{Product.count} product(s)!"
