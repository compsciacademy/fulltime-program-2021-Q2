# Day 11

Think through the game we have been working on, and make a list of _features_ that can act as vertical slices. That is, stand alone features that can be implemented and tested without relying on other features to be implemented.  
  
It's possible that some features will build on others, and/or that some sets of features will require others to have been implemented. For example, a player must exist for a player to obtain a cat.  
  
## Exercise 01  
  
Create a list of features that the game should support. Let's follow this rule: Our MVP (Minimal Viable Product) is also going to be our MAF (Maximum Available Features). That is, do not add any features unless they are absolutely necessary, e.g. A Player must have a Cat to enter into a competition.  
  
When someone starts the game, they are prompted to find or create their player character.

  * start game
    * select game style (player vs player or computer)
        * find or create Player
            * select or get a cat
                * select: from a list of player owned cats
                * get: how to get a cat? *PENDING v2 (for now, a player will start with a cat)

    * load and run competition
        * display competition outcome
    * compete again or quit

Start Game
    Describe what starting a game entails here.  
      
Find or Create Player  
    Describe what Find or Create Player entails here.  
  
Get a Cat  
    Describe what geting a cat entails here.  
      
