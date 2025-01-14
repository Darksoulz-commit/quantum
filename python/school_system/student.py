# student.py

from school import School
from pymongo import MongoClient

class Student(School):
    def __init__(self, name, marks):
        self.role = 'Student'
        super().__init__(name, self.role)
        self.marks = marks
        self.name = name
        # MongoDB Setup: Replace the MongoDB URI with your own
        self.client = MongoClient('mongodb://localhost:27017')  # If you're using a local MongoDB
        self.db = self.client['school_database']  # MongoDB Database name
        self.student_collection = self.db['students']  # MongoDB collection for students

    def average(self):
        l = list(self.marks.values())
        avg = sum(l) // len(l)
        return avg

    def grade(self, avg):
        if avg > 90:
            return 'O'
        elif 70 < avg <= 90:
            return 'B'
        elif 50 < avg <= 70:
            return 'A'
        elif 35 < avg <= 50:
            return 'E'
        elif avg < 35:
            return 'F'

    def display(self):
        return f'{self.name} has scored {self.marks} and got {self.grade(self.average())}'

    def insert_student(self):
        student_data = {
            'name': self.name,
            'marks': self.marks,
            'role': self.role,
            'average': self.average(),
            'grade': self.grade(self.average())
        }
        self.student_collection.insert_many(student_data)  # Insert student record into MongoDB

    def update_student(self, student_name, new_marks):
        self.student_collection.update_many(
            {'name': student_name},
            {'$set': {'marks': new_marks, 'average': self.average(), 'grade': self.grade(self.average())}}
        )  # Update student marks

    def delete_student(self, student_name):
        self.student_collection.delete_one({'name': student_name})  # Delete student record

    def read_student(self, student_name):
        student = self.student_collection.find_one({'name': student_name})
        if student:
            return student
        return None
