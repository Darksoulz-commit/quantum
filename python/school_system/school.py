# school.py

class School:
    def __init__(self, pname, prole):
        self.pname = pname
        self.prole = prole

    def checkwho(self):
        if self.prole == 'Teacher':
            print(f'as a Teacher {self.pname}')
        else:
            print(f'as a Student {self.pname}')
