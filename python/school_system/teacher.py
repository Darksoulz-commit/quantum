# teacher.py

from school import School
# from student import Student
from pymongo import MongoClient

class Teacher(School):
    def __init__(self, tname, tsub):
        self.role = 'Teacher'
        super().__init__(tname, self.role)
        self.tname = tname
        self.tsub = tsub
        # MongoDB Setup: Replace the MongoDB URI with your own
        self.client = MongoClient('mongodb://localhost:27017')  # If you're using a local MongoDB
        self.db = self.client['school_database']  # MongoDB Database name
        self.teacher_collection = self.db['teachers']  # MongoDB collection for teachers

    def teacher_display(self):
        return f'Teacher name is: {self.tname} teaches {self.tsub}'

    def insert_teacher(self):
        teacher_data = {
            'name': self.tname,
            'subject': self.tsub,
            'role': self.role
        }
        self.teacher_collection.insert_one(teacher_data)  # Insert teacher record into MongoDB

    def update_teacher(self, teacher_name, new_subject):
        self.teacher_collection.update_one(
            {'name': teacher_name},
            {'$set': {'subject': new_subject}}
        )  # Update teacher subject

    def delete_teacher(self, teacher_name):
        self.teacher_collection.delete_one({'name': teacher_name})  # Delete teacher record

    def read_teacher(self, teacher_name):
        teacher = self.teacher_collection.find_one({'name': teacher_name})
        if teacher:
            return teacher
        return None
    
    def cal_pass():
        pass
