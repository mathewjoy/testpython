from initdata import sue
class Person:
    def __init__(self, name, age, pay=0, job=None):
        self.name = name
        self.age = age
        self.pay = pay
        self.job = job
    def giveRaise(self, percent):
        self.pay *= (1.0 + percent)

    def __str__(self):
        return ('%s --> %s, %s , %s' %
                (self.__class__.__name__, self.name, self.job, self.pay)
                )
            
if __name__ == '__main__':
    bob = Person('Bob', 23, 200, 'Programmer')
    sue = Person('Sue', 30, 100, 'Architect')
    
    '''print([dict(
                (o, getattr(sue, o)) #tuple
            for o in dir(sue) 
                if not o.startswith('__')
                )
           ]
          )
    '''      
    print(bob, '/' , sue)
    
    
    