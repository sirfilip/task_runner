require 'spec_helper'

require 'task_runner/task'

describe TaskRunner::Task do 
  it 'can be created with name, action and description' do 
    task = TaskRunner::Task.new('name', Proc.new {}, '')
    task.name.must_equal 'name'
    task.description.must_equal ''
  end

  it 'must have a callable action argument' do 
     err = lambda do 
       TaskRunner::Task.new('name', 'an action', '')
     end.must_raise ArgumentError
     err.message.must_equal 'Action must be callable'
  end

  it 'can invoke the action' do 
    action = mock('callable')
    action.stubs(:call).returns(nil)
    task = TaskRunner::Task.new('name', action, '')
    task.must_respond_to :invoke
    action.expects(:call)
    task.invoke
  end
end
