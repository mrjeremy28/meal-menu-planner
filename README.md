# Meal Menu Planner

## Future Specs include
* Ability to create menu from list of meals
* Edit List of Meals
* Create/edit recipes
* List of Ingredients
* Grocery List
* Task Manager

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:


## System Requirements

* Ruby 3.3+ recommended
* Postgres 16 or later, MySQL v4.1.1 or later (v5+ is recommended), SQLite v3.4 or later.


(Ruby on Rails and other gem dependencies will be installed automatically by Bundler.)

## Installation
```
bundle install
```
```
rake db:create
```
```
rake db:migrate
```

## Start Server
```
rails s
```

## Resources

|||
|-----------------------------------:|:--------------------------|
## Schema (Ideal)
- Users
    - name:        string
    - email:       string
    - password:    string

- Recipes
    - name:         string
    - servings:     int
    - instructions: text
    - category:     relationship
    - picture:      relationship

- RecipeGroups - TODO
    - name:        string

- RecipeLabels - TODO
    - name:       string

- RecipeTags - TODO
    - name:        string

- RecipeCategories
    - name:        string

- Ingredients
    - name:                string
    - description:         string
    - defaultQuantityUnit: relationship
    - image:               relationship

- RecipeIngredients
    - recipe        relationship
    - ingredient    relationship
    - quantityUnit  relationship
    - quantity      string
    - numerator     int
    - denomator     int
    - order         int
    - customAmount    string -> i.e. if easier to say 4 Cups, 1 tablespoon, than 4 1/16 Cup - TODO
    - group       string      -> if ingredients are part of group, like for Sauce, or for - main - TODO
    - comments    string  - TODO

- QuantityUnits
    - name                string  i.e. Cups
    - maxDisplayAmount    int  i.e. if >= 4 Cups max, then show 1 Quart - TODO
    - maxDisplayUnitTo    relationship i.e. cups to Quart if over - TODO

- QuantityUnitConversions - TODO
    - unitFrom    relationship
    - unitTo      relationship
    - multiplier  decimal