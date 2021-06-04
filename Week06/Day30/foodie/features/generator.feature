Feature: Generate Recipes
    In order to generate Recipes
    As a CLI
    I want foodie to generate them

    Scenario: Recipes
        When I run `foodie recipe dinner steak`
        Then the following files should exist:
            | dinner/steak.txt |
        Then the file "dinner/steak.txt" should contain:
            """
            ##### Ingredients #####
            Ingredients for delicious steak go here.

            ##### Instructions #####
            Tips on how to make delicious steak go here.
            """
