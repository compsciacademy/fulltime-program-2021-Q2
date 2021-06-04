# Day 30  
  
Let's continue with our gem. Last time, we looked at [gem scaffolding](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#using-bundler-to-create-a-gem), i.e. the setup that bundle gives us when we run the command: `bundle gem <gem name>`. We then looked at adding some functionality and [testing with Rspec](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#testing-with-rspec). Additionally, we [added a CLI](https://github.com/compsciacademy/fulltime-program-2021-Q2/tree/main/Week06/Day29#add-a-cli) using Thor, and tested it with Aruba and Cucumber.  
  
## Generators  
  
Let's add a generator for a _recipes_ directory. We should be able to run the generator something like this:
```
foodie recipe dinner steak
```

This should generate a `recipes/` directory (if it doesn't already exist), a `dinner/` directory inside of it (also, if it doesn't already exist), and a `steak.txt` file inside the `dinner/` directory.  
  
The `steak.txt` file should have the appropriate setup text for ingredients and the instructions for how to prepare it.  
  
Aruba has ways to test that a generator generates files and directories, so let's use that to our advantage and write some feature tests!  
  
Create a new file called `features/generator.feature`:
  
```yaml
Feature: Generating things
    In order to generate recipes
    As a CLI
    I want foodie to generate them for me

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

```