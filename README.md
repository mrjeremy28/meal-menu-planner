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
    - name:        string
    - yield:       int
    - instructions: text
    - picture: relationship

- RecipeGroups
    - name:        string

- RecipeLabels
    - name:       string

- RecipeTags
    - name:        string

- RecipeCategories
    - name:        string

- Ingredients
    - name:                string
    - description:         string
    - defaultQuantityUnit: relationship
    - image:               relationship

- RecipeIngredients
    - recipe      relationship
    - ingredient  relationship
    - fraction    boolean
    - numerator   int
    - denomator   int
    - quantity    decimal
    - customAmount    string -> i.e. if easier to say 4 Cups, 1 tablespoon, than 4 1/16 Cup
    - group       string      -> if ingredients are part of group, like for Sauce, or for - main
    - comments    string 

- QuantityUnits
    - name                string  i.e. Cups
    - maxDisplayAmount    int  i.e. if >= 4 Cups max, then show 1 Quart
    - maxDisplayUnitTo    relationship i.e. cups to Quart if over

- QuantityUnitConversions
    - unitFrom    relationship
    - unitTo      relationship
    - multiplier  decimal