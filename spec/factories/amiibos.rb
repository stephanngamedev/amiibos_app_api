FactoryGirl.define do
	factory :ness, class: Amiibo do
		name "Ness"
		series_id 1
		release_date "29/05/2015"
		company_id 1
		description %q{ 
			Ness is a small-town kid and the main protagonist of 
			the beloved game Earthbound. His ordinary looks hide his 
			psychic PSI powers. Ness was living a normal life in the 
			suburbs of Onett until a meteor crashed into a nearby mountain 
			and sent him on a wild adventure. Believing in the ultimate 
			powers of wisdom, courage, and friendship, Ness proves that 
			some heroes come in small packages."
		}
		detail_image_url "http://media.nintendo.com/nintendo/bin/0KugQl0uMfq3OLVPbpxt8-hyjsyeaKTn/3dOPZ69UnKIiemhy02qpjNO4NX1GiWEo.png"
		boxart_image_url "http://media.nintendo.com/nintendo/bin/dYeckYYRil0rZDgIPiNdNWFlrNDWNA6W/LpTLtCp74r7GjxpTrvGSzj0pWb9VQP_i.png"
	end
end
