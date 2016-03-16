require File.expand_path('../task', __FILE__)

module TaskRunner 

  class DSL
    attr_accessor :task_manager

    def initialize(task_manager)
      @task_manager = task_manager
      @description = ''
    end

    def desc(description)
      @description = description
    end

    def task(name, &block)
      deps = []
      description = @description
      @description = ''
      if name.is_a? Hash 
        deps = [name.values.first].flatten
        name = name.keys.first
      end
      task_manager.add(Task.new(name, block, description), deps)
    end

    def parse(code)
      instance_eval code
    end

  end

end
