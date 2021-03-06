/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

abstract class PowerUp extends GameObject
{
  float accel = 30;
  StopWatch directionSW;
  StopWatch durationSW;

  PowerUp(PApplet applet, String imgFileName, int xpos, int ypos, float speed) 
  {
    super(applet, imgFileName, 51);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(1.0);
    setSpeed(speed, random(0, 7));
    directionSW = new StopWatch();
    durationSW = new StopWatch();

    // Domain keeps the moving sprite withing specific screen area 
    // setDomain(0, 0, applet.width, applet.height, Sprite.REBOUND );

    soundPlayer.playPop();
  }

  void update() 
  {
    float ellapsed = (float)durationSW.getRunTime();
    setScale(sin(ellapsed + .25));

    // Change direction every N seconds.
    if (directionSW.getRunTime() > 3) {
      directionSW.reset();
      double dir = getDirection() + random(1, 3.6);
      setDirection(dir);
    }

    // Run missile for 15 seconds
    if (durationSW.getRunTime() > 15) {
      super.setInactive();
      soundPlayer.playPop();
    }
    setXY((getX()+game.width)%(game.width), (getY()+game.height)%(game.height));
  }

  abstract void activate(Ship ship);
}


/*****************************************/

class ShieldPowerup extends PowerUp 
{

  ShieldPowerup(PApplet game, int xpos, int ypos, float speed) 
  {
    super(game, "powerup.png", xpos, ypos, speed);
  }

  void activate(Ship ship)
  {
    ship.setShield(15);
    soundPlayer.playPop();
  }

  void drawOnScreen() {
  }
}

/*****************************************/

class LifePowerup extends PowerUp 
{

  LifePowerup(PApplet game, int xpos, int ypos, float speed) 
  {
    super(game, "powerup.png", xpos, ypos, speed);
  }

  void activate(Ship ship)
  {
    if (ship == ship1)
    {
      if(playerOneRemainingLives < startLives){
          playerOneRemainingLives++;
          P1lives.add(new Image(game, "ship1.png", 50 * P1lives.size() + XLivesOffset, YLivesOffset));
      }
      else {
        println("Already at max health.");
      }
    }
    if (ship == ship2)
    {
      if(playerTwoRemainingLives < startLives){
          playerTwoRemainingLives++;
          P2lives.add(new Image(game, "ship2.png", game.width - (50 * P2lives.size() + XLivesOffset), YLivesOffset));
      }
      else {
        println("Already at max lives.");
      }
    }
    soundPlayer.playPop();
  }

  void drawOnScreen() {
  }
}

/*****************************************/

class FreezePowerup extends PowerUp 
{
  FreezePowerup(PApplet game, int xpos, int ypos, float speed) 
  {
    super(game, "powerup.png", xpos, ypos, speed);
  }

  void activate(Ship ship)
  {
    ship.freeze(8);
    soundPlayer.playPop();
  }

  void drawOnScreen() {
  }
}
