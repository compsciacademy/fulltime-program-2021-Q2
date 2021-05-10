# Day 11

Think through the game we have been working on, and make a list of _features_ that can act as vertical slices. That is, stand alone features that can be implemented and tested without relying on other features to be implemented.  
  
It's possible that some features will build on others, and/or that some sets of features will require others to have been implemented. For example, a player must exist for a player to obtain a cat.  
  
## Exercise 01  
  
Create a list of features that the game should support. Let's follow this rule: Our MVP (Minimal Viable Product) is also going to be our MAF (Maximum Available Features). That is, do not add any features unless they are absolutely necessary, e.g. A Player must have a Cat to enter into a competition.  
  
When someone starts the game, they are prompted to find or create their player character.

  * start game
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
    

**Start Game**  
To start a game, select start game. You will be prompted to **Find or Create a Player**. 

  * **Create a Player**: You will be prompted to give a player name. The name must not be the name of an already existing player.
  * **Find a Player**: You are prompted to give the name of a player. If the player is found by that name, it will be loaded as the current player. If not, you are told that there is no player by that name, and prompted to select whether to find or create a player.

     * **Get a Cat**: A player has cats. Initially, when a player is created, they will be given a starter cat. More ways to obtain cats will be added in future versions.

One you have a player selected, you can select to compete in a competition or quit.  
  
**Compete in a Compeition**  
There are two competitions for v1, where Player1's Cat competes against Player2's Cat: Playfight or Race.  
  
  **Playfight**: A best of 3 rounds, where the winner is determined by _an algorithm_. 
  **Race**: The faster cat will win. There are 3 rounds. "Faster" is determined by ... _an algorithm_.
  

**Our UI**  
  
What is our user flow? What is the decision tree? We need to define everything or nothing will make sense!  
  
Initially, we have a decision to do one of three things: Quit, Find Player, Create Player. What happens after each decision?  
  
  * **Quit**: exit the game (program ends)
  * **Find Player**: (As described above) And then what???
  * **Create Player**: (As described above) And then what???
    * **And then what???**: The competition begins
      * **The Competition**: Select Competition Type, then compete.
            A player's cat will compete to win, lose, or draw. Each ending will have its own outcome with rewards or penalties depending on _something_ (e.g. cat attributes, the game algorithms, and of course whether the cat won, lost, or tied).
      * **Compete Again or Quit**

## Exercise 02
  
Create a new repository on Github. Give it a name, perhaps Kitty Comp, to differentiate it from our previous work.  
  
Create a program that satisfies the feature requirements for our MVP. The userflow for which is outlined below.  
  
**Start or Quit**  
    We are prompted to start a game or quit the program.  

  * **Quit**: Exits the program  
  * **Start**: New Player or Select Player
    * **Select Competition**: Race or Playfight
    * **Compete**: Win, Lose, or Draw
  * **Compete Again or Quit**: Repeat or Exit
