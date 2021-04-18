import javax.swing.JOptionPane;
int askInteger()
{
  int i = 0;
  String r = JOptionPane.showInputDialog(null, "Entrez un entier", "askInteger", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Integer.parseInt(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un entier!");
  }
  return i;
}
int askInteger(String s)
{
  int i = 0;
  String r = JOptionPane.showInputDialog(null, s, "askInteger", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Integer.parseInt(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un entier!");
  }
  return i;
}
float askFloat()
{
  float i = 0;
  String r = JOptionPane.showInputDialog(null, "Entrez un réel", "askFloat", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Float.parseFloat(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un réel!");
  }
  return i;
}
float askFloat(String s)
{
  float i = 0;
  String r = JOptionPane.showInputDialog(null, s, "askFloat", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Float.parseFloat(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un réel!");
  }
  return i;
}
double askDouble()
{
  double i = 0;
  String r = JOptionPane.showInputDialog(null, "Entrez un réel", "askDouble", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Double.parseDouble(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un réel!");
  }
  return i;
}
double askDouble(String s)
{
  double i = 0;
  String r = JOptionPane.showInputDialog(null, s, "askDouble", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = Double.parseDouble(r);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un réel!");
  }
  return i;
}
char askChar()
{
  char i = 0;
  String r = JOptionPane.showInputDialog(null, "Entrez un caractère", "askChar", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = r.charAt(0);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un caractère!");
  }
  return i;
}
char askChar(String s)
{
  char i = 0;
  String r = JOptionPane.showInputDialog(null, s, "askChar", JOptionPane.QUESTION_MESSAGE);
  try 
  {
    i = r.charAt(0);
  } 
  catch(NumberFormatException e) 
  {
    println("Ce n'est pas un caractère!");
  }
  return i;
}
String askString()
{

  String r = JOptionPane.showInputDialog(null, "Entrez une chaine de caractère", "askString", JOptionPane.QUESTION_MESSAGE);
  return r;
}
String askString(String s)
{
  String r = JOptionPane.showInputDialog(null, s, "askString", JOptionPane.QUESTION_MESSAGE);
  return r;
}
