from person_class import Person
class Manager(Person):
    def __init__(self, name, age, pay):
        Person.__init__(self, name, age, pay, 'manager')
        
    def giveRaise(self, percent, bonus=.1):
        #self.pay *= (1 + percent + bonus)
        Person.giveRaise(self, percent+bonus)
        
    def lastName(self):
        return self.name.split()[-1]
    
if __name__ == '__main__':
        tom = Manager(name='Tom Joe', age=50, pay=50000)
        print(tom.lastName())
        tom.giveRaise(.2)
        print(tom.pay)