# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

amiibos = ActiveSupport::JSON.decode(File.read('db/amiibos.json'))

amiibo_count = Amiibo.count
series_count = Series.count
company_count = Company.count

amiibos.each do |amiibo|
	amiibo['company_id'] = Company.find_or_create_by!( name: amiibo['company'] ).id
	amiibo['series_id'] = Series.find_or_create_by( name: amiibo['series'] ).id || nil
	amiibo.except!( 'series', 'company' )
	
	Amiibo.find_or_create_by!( amiibo )
end

pp "Created #{Company.count - company_count} companies"
pp "Created #{Series.count - series_count} series"
pp "Created #{Amiibo.count - amiibo_count} amiibos"