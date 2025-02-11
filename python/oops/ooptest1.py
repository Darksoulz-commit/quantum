class Human:
    def __init__(self,n='farmer',o='agri'):
        self.name =n
        self.occupation = o

    def do_work(self):
        if self.occupation == 'tennis player':
            print(self.name, 'plays tennis')
        elif self.occupation == 'actor':
            print(self.name,'shoots flim')
        elif self.occupation == 'agri':
            print(self.name,'does agri')
    
    def speaks(self):
        print(self.name, 'says how are you?')
        


