# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_file = Rails.root.join('db', 'seeds', 'seeds.yml')
config = YAML::load_file(seed_file)

config['projects'].each do |project|
    p = Project.new(title: project["title"])
    p.save!

    project["todos"].each do |todo|
        t = Todo.create(todo)
        t.project = p
        t.save!
    end
    p.save!
end
