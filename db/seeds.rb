require 'faker'
require "open-uri"

puts 'creating users...'
10.times {
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'tenoch'
    )
}
puts 'users created'

puts 'creating meals & related picture...'
meal_list = [
  ['Mezcal Tasting and Great Food in Roma', 'Orizaba 113, Col. Roma. CDMX', 'https://travesiasdigital.com/wp-content/uploads/2019/01/mezcal-header.jpg'],
  ['Brunch at Polanco Terrace', 'Av. Emilio Castelar 135, Polanco. CDMX', 'https://decoracion2.com/imagenes/2019/03/ideas-para-convertir-tu-terraza-en-un-auntentico-oasis-15.jpg'],
  ['Homemade Tacos al Pastor', 'Durango 187, Roma Norte. CDMX', 'https://dam.cocinafacil.com.mx/wp-content/uploads/2019/04/Trompo-casero.jpg'],
  ['Italy meets Mexico in Polanco', 'Virgilio 40, Polanco. CDMX', 'https://media.timeout.com/images/100451423/image.jpg'],
  ['Authentic Taco Tasting Menu', 'Michoacán 172, Hipódromo Condesa. CDMX', 'https://www.pirateshipvallarta.com/blog/wp-content/uploads/2018/03/recommendations-for-taco-tasting-in-puerto-vallarta.jpg'],
  ['3 Amigos Evening with Amazing Food', 'Paseo de la Reforma 465, Juárez.. CDMX', 'https://www.europassitalian.com/wp-content/uploads/2020/03/Guys-cooking-1600x900.jpg'],
  ['Family Dinner at Centro de Mexico', 'Isabel la Católica 30, Centro Histórico. CDMX', 'https://cdn.lifehack.org/wp-content/uploads/2018/10/family-dinners.jpeg'],
  ['Mexican Cooking Lessons + Wine', 'Av. Ignacio Allende 3. CDMX', 'https://cdn.shortpixel.ai/spai/w_1163+q_lossy+ret_img/https://beautifuliguria.com/wp-content/uploads/2018/11/cook-dine-genoa2-1920x999.jpg'],
  ['Grandmas Secret Recipes with Modern Twist', 'Calle Isabel la Católica 30. CDMX', 'https://cdn.sunbasket.com/dae22b7b-944f-4183-9108-dd58487ec3f2.jpg'],
  ['Mexican Basement Dinner with Friends', '5 de Mayo 61, Centro Histórico. CDMX', 'https://insiderotterdam.nl/wp-content/uploads/2018/09/zd0C5hQ-1024x480.jpeg'],
  ['Tequila Tasting at Pablos Kitchen', 'República de Cuba 96, Centro Histórico. CDMX', 'https://previews.123rf.com/images/rawpixel/rawpixel1711/rawpixel171108696/90706964-group-of-friends-are-cooking-in-the-kitchen.jpg'],
  ['Wine Paring Meal at Mexican Sommellier Apartment', 'Juárez 70, Centro Histórico. CDMX', 'https://purewows3.imgix.net/images/articles/2019_03/ruffina-wine-bar-ny.jpg?auto=format,compress&cs=strip'],
  ['Authentic Mole for Authentic Travellers', '16 de Septiembre 82. CDMX', 'https://media.wsimag.com/attachments/e44f627d934b13a82d9e00d622cb7a590fb8f099/store/fill/1230/692/b396db79aef8f0ed5646b43304dbcaf3e68278e3913bc6f378eefbc8cfb4/Mole.jpg'],
  ['Beer Tasting and Good Food with Locals', 'Calle República de Argentina 15 Planta Alta. CDMX', 'https://img.grouponcdn.com/deal/rWkQN4AyHpgx3CNpeXb/is-5000x3000/v1/c700x420.jpg'],
  ['Exquisite Vegan Afternoon with Lou', 'Filomeno Mata 18 Loc. 6 y 7 Altos, Centro Histórico. CDMX', 'https://149366112.v2.pressablecdn.com/wp-content/uploads/2018/10/bowl-4-1067x800.jpg']
]

meal_list.each do |name, address, picture|
  meal = Meal.create(
      name: name,
      description: Faker::Hipster.paragraph,
      price: [150, 200, 250, 300, 350, 400, 450, 500, 550, 600].sample,
      address: address,
      min_eaters: rand(1..2),
      max_eaters:rand(2..10),
      user_id: rand(1..10),
      open_hrs: Faker::Time.forward(days: 30, period: :morning).strftime("%k:%M"),
      close_hrs: Faker::Time.forward(days: 30, period: :evening).strftime("%k:%M"),
      open_days: ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'].sample(4)
      )
  file = URI.open(picture.to_s)
  meal.photos.attach(io: file, filename: 'meal.png', content_type: 'image/png')
end
puts 'meals & related picture created'

puts 'adding 1st additional random photo to meals...'
zoom_in = [
  'https://cdn.forkly.com/eyJidWNrZXQiOiJwdWItc3RvcmFnZSIsImtleSI6ImZvcmtseS93cC1jb250ZW50L3VwbG9hZHMvMjAxNy8wNS9lYXN5LWZpc2gtdGFjb3Mtd2l0aC1saW1lLWNyZW1hLTYuanBnIiwiZWRpdHMiOnsicmVzaXplIjp7IndpZHRoIjo3NDgsImhlaWdodCI6MzkwLCJmaXQiOiJjb3ZlciIsImJhY2tncm91bmQiOnsiciI6MCwiZyI6MCwiYiI6MCwiYWxwaGEiOjF9fX19',
  'https://theinspiredhome.imgix.net/images/Loaded-Mediterranean-Street-Fries-2-2_171003_140630.jpg?fit=clip&q=80&w=850',
  'https://tipsparatuviajecom62b65.zapwp.com/q:intelligent/retina:false/webp:true/w:1024/url:https://tipsparatuviaje.com/wp-content/uploads/2018/09/enchiladas-comida-mexicana.jpg',
  'https://www.cosasmexico.com/wp-content/uploads/2017/11/comida-mexicana-platillos.jpg',
  'https://de10.com.mx/sites/default/files/styles/imagen_body/public/2018/06/28/spaghetti_a_la_bolonesa.jpg?itok=UXEmZsqD',
  'https://goangelscatering.com/wp-content/uploads/2017/07/mediterranean-food.-e1499119332962.png',
  'https://www.bbcgoodfood.com/sites/default/files/guide/guide-image/2015/01/mediterranean-diet-guide-main-image-700-350.jpg',
  'https://media-api.xogrp.com/images/4d170c12-5e58-441a-ac2e-a0b9457d6134',
  'https://houstonfoodfinder.com/wp-content/uploads/2020/01/chicken_bowl_craft_pita_w_rice.jpg',
  'https://www.laespanolaaceites.com/wp-content/uploads/2019/05/empanadas-de-matambre-1080x671.jpg',
  'https://www.superama.com.mx/views/micrositio/recetas/images/fiestaspatrias/enchiladasverdes/Web_fotoreceta.jpg',
  'https://theculturetrip.com/wp-content/uploads/2017/12/shutterstock_291776018.jpg'
]

Meal.all.each do |meal|
  file = URI.open(zoom_in.sample.to_s)
  meal.photos.attach(io: file, filename: 'meal1.png', content_type: 'image/png')
end
puts '1st additional photo, done'


puts 'adding 2nd additional random photo to meals...'
zoom_out = [
  'https://cdn.makespace.com/blog/wp-content/uploads/2018/01/05155747/The-Stress-Free-Guide-To-Hosting-Your-First-Dinner-Party-8-Steps-With-Pictures1.jpg',
  'https://media3.s-nbcnews.com/i/newscms/2019_05/2736521/190131-stock-taco-bar-food-ew-1220p_bc7c9fc25ecd393bfa3d7d35f216edfc.jpg',
  'https://scoopempire.com/wp-content/uploads/2019/05/healthy-potluck-table.jpg',
  'https://img.huffingtonpost.com/asset/5cd3708a2100005800d3b0c5.jpeg?ops=scalefit_720_noupscale',
  'https://www.thetopvillas.com/blog/wp-content/uploads/2017/09/Webp.net-resizeimage-88.jpg',
  'https://www.sustainabilityhackers.com/wp-content/uploads/2016/01/sustainable-dinner-party-feature-min.jpg',
  'https://img.huffingtonpost.com/asset/58504f481200001400eef186.jpeg?ops=scalefit_720_noupscale',
  'https://www.minnesotamonthly.com/wp-content/uploads/sites/85/2019/02/kelsey-chance-575535-unsplash-1.jpg',
  'https://www.havanahouse.co.uk/wp-content/uploads/2017/12/tablee.png',
  'https://image.freepik.com/free-photo/top-view-friends-having-dinner_23-2147716913.jpg',
  'https://www.lacrema.com/wp-content/uploads/2015/03/NvN9p9Jj6oZLEx897kRmI-MR7U7pyA8ARyeQE2ZlUAolivHOpGBLUIaEq3lvGblV642AXGUS9ppGV5QhPegz7E-1024x682.jpeg',
  'https://blogmedia.evbstatic.com/wp-content/uploads/rally-legacy/2018/02/22130135/twenty20_426cb6b2-2822-4c02-8934-5f27c069175a-1500x750.jpg',
  'https://cookforsyria.com/wp-content/uploads/2016/10/hosting-dinner.jpg'
]

Meal.all.each do |meal|
  file = URI.open(zoom_out.sample.to_s)
  meal.photos.attach(io: file, filename: 'meal2.png', content_type: 'image/png')
end
puts '2nd additional photo, done'


puts 'creating bookings & reviews...'
30.times {
  user = rand(1..10)
  meal = rand(1..15)
    Booking.create!(
      date: Faker::Time.forward(days: 30),
      eaters: rand(2..5),
      user_id: user,
      meal_id: meal
      )
  Review.create!(
    comment: Faker::Restaurant.review,
    rating: rand(0..5),
    user_id: user,
    meal_id: meal
    )
}
puts 'bookings & reviews created'
