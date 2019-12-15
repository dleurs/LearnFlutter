class Person 
{
  String name;
  int livePoint;
  Person(String inputName,{int inputLivePoint = 100})
  {
    this.name = inputName;
    this.livePoint = inputLivePoint;
  } // constructor Person
  void dammageReceived(int attackPoint)
  {
    this.livePoint -= attackPoint;
    if (this.livePoint <= 0)
    {
      this.livePoint = 0;
      print("The person ${this.name} is dead");
    } // if (this.livePoint <= 0)
  } // function dammageReceived
} // class Person

void main() 
{
  Person robert = Person("Robert");
  Person vladimir = Person("Vladimir", inputLivePoint:150);
  print(robert.livePoint);
  print(vladimir.livePoint);
  robert.dammageReceived(110);
}