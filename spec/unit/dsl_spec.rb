require 'spec_helper'
require 'task_runner/dsl'
require 'task_runner/task_manager'
require 'task_runner/task'


#TODO find the best way to test this....
describe TaskRunner::DSL do 

  let(:dsl) { TaskRunner::DSL.new(TaskRunner::TaskManager.new) }

  it 'has a task manager to manage the tasks' do 
    dsl.task_manager.wont_be_nil
  end
end
