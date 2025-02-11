# main.py

from teacher import Teacher
from student import Student

def main():
    # # Creating a Teacher object
    # teacher = Teacher('Mr. Smith', 'Mathematics')
    # print(teacher.teacher_display())
    # teacher.insert_teacher()  # Insert teacher into MongoDB

    # teacher.update_teacher('Mr. Smith', 'Physics')  # Update teacher subject
    # print(teacher.read_teacher('Mr. Smith'))
    # # teacher.delete_teacher('Mr. Smith')  # Delete teacher from MongoDB

    # # Creating a Student object
    # marks = {'Math': 90, 'English': 80, 'Science': 85}
    # student = Student('John Doe', marks)
    # print(student.display())
    # Student.insert_student()  # Insert student into MongoDB
    # student.update_student('John Doe', {'Math': 92, 'English': 84, 'Science': 88})  # Update student marks
    # print(student.read_student('John Doe'))
    # student.delete_student('John Doe')  # Delete student from MongoDB

    # # Student.insert_student()  # Insert student into MongoDB
    # Student.insert_student('AliceBrown', {'Math': 88, 'English': 91, 'Science': 85, 'Social': 90})
    # Student.insert_student('BobJohnson', {'Math': 76, 'English': 80, 'Science': 83, 'Social': 78})
    # Student.insert_student('CharlieDavis', {'Math': 95, 'English': 89, 'Science': 92, 'Social': 87})
    # Student.insert_student('DianaMiller', {'Math': 82, 'English': 87, 'Science': 78, 'Social': 84})
    # Student.insert_student('EvaWilson', {'Math': 90, 'English': 88, 'Science': 92, 'Social': 85})
    # Student.insert_student

    student_obj = Student('FrankMoore', {'Math': 72, 'English': 76, 'Science': 85, 'Social': 89})
    student_obj.insert_student()

  

if __name__ == '__main__':
    main()
