class Employee
  attr_reader :fn, :ln, :title, :salary
  def initialize(fn, ln, title, salary)
    @fn, @ln, @title, @salary = fn, ln, title, salary
  end
  
  def bonus(multiplier)
    @salary * multiplier
  end
  
  def assign_boss(manager)
    manager.add_employee(self)
    @manager = manager
  end
end

class Manager < Employee
  def initialize(fn, ln, title, salary)
    super
    @employees = []
  end
  
  def add_employee(employee)
    @employees << employee
  end
  
  def bonus(multiplier)
    (self.salary + get_salaries) * multiplier
  end
  
  def get_salaries
    salary_sum = 0
    @employees.each do |employee|
      salary_sum += employee.salary
      salary_sum += employee.get_salaries if employee.is_a?(Manager)
    end
    salary_sum
  end
end