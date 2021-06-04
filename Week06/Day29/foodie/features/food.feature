Feature: Food
    In order to portray or pluralize food
    As a CLI
    I want to be as objective as possible

    Scenario: Broccoli is gross
        When I run `foodie portray broccoli`
        Then the output should contain "Gross!"

    Scenario: Tomato to Tomatoes
        When I run `foodie pluralize --word Tomato`
        Then the output should contain "Tomatoes"
        