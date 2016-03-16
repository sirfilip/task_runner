require File.expand_path('../dsl', __FILE__)
require File.expand_path('../task_manager', __FILE__)


module TaskRunner


  class Runner 

    DEFAULT_MANIFEST = 'TaskRunnerFile'

    attr_reader :task_manager
    
    def initialize(code)
      @task_manager = TaskManager.new
      DSL.new(@task_manager).parse(code)
    end

    def run_task(task_name)

      task = task_manager.find(task_name)
      task_manager.deps(task_name).each { |t| run_task(t.name) }
      task.invoke

    end

  end

end


