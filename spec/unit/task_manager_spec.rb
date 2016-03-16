require 'spec_helper'
require 'task_runner/task_manager'

describe TaskRunner::TaskManager do 
  let(:tm) { TaskRunner::TaskManager.new }

  it 'has no tasks by default' do 
    tm.tasks.must_be :empty?
  end

  describe '#add_task' do 
  
    it 'can accept tasks' do 
      task = mock('task')
      task.stubs(:name).returns('a task')
      tm.add(task)
      tm.find('a task').must_equal task
    end

    it 'can attach dependencies to a task' do 
      task1 = mock('task')
      task1.stubs(:name).returns('task1')
      tm.add(task1)
      task2 = mock('task')
      task2.stubs(:name).returns('task2')
      deps = ['task1']
      tm.add(task2, deps)
      tm.find('task2').must_equal task2
      tm.deps('task2').must_equal [task1] 
    end

  end

  describe '#find' do 

    it 'raises an error if a task cannot be found' do 
      err = lambda do 
        tm.find('non existing task') 
      end.must_raise TaskRunner::TaskNotFoundError
      err.message.must_equal "Task with name 'non existing task' does not exist"
    end

  end
end
