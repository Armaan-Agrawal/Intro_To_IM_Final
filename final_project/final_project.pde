int gamescreen = 0; 

void setup()
{
  size(1280,960);
  
}

void draw()
{
  switch(gamescreen) {
    case 0: 
      menu();
      break;
    case 1: 
      choose_circuit();
      break;
    case 2:
      instruction();
      break;
    case 3:
      setting();
      break;
    case 4:
      gameover();
      break;
    case 5:
      pause();
      break;
    default:
      break;
  }
}
