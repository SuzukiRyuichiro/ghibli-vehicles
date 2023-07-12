require 'open-uri'
require 'json'

namespace :ghibli_api do
  desc 'Import vehicles and films appeared to the databse from Ghibli API'
  task import_vehicles: :environment do
    vehicles_data = JSON.parse(URI.open('https://ghibli.rest/vehicles').read, symbolize_names: true)
    vehicles_data.each do |vehicle_data|
      # Make films
      film_urls = vehicle_data[:films]
      films = film_urls.map do |film_url|
        film_data = JSON.parse(URI.open(film_url).read, symbolize_names: true)
        film_data[:image_url] = film_data.delete :image
        Film.find_or_create_by(film_data.slice(:title, :image_url, :description, :director))
      end

      # Make vehicle
      vehicle_data[:pilot] = JSON.parse(URI.open(vehicle_data[:pilot]).read, symbolize_names: true)[:name]
      vehicle = Vehicle.find_or_create_by(vehicle_data.slice(:name, :description, :vehicle_class, :pilot))

      # Make film to have many vehicles
      films.each do |film|
        Appearance.find_or_create_by(film:, vehicle:)
      end
    end

    puts "Created #{Film.count} films and #{Vehicle.count} vehicles"
  end
end
