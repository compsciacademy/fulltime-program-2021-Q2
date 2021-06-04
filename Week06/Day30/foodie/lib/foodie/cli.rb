require 'thor'
require 'foodie'
require 'foodie/generators/recipe'

module Foodie
  class CLI < Thor
    desc "portray [FOOD]", "Determines where a food item is gross or delicious"
    def portray(food)
      puts Foodie::Food.portray(food)
    end

    desc "pluralize -w/--word [WORD]", "Pluralizes a word"
    method_option :word, aliases: "-w"
    def pluralize
      puts Foodie::Food.pluralize(options[:word])
    end

    desc "recipe", "Generates a recipe scaffold"
    def recipe(group, name)
      Foodie::Generators::Recipe.start([group, name])
    end
  end
end
