module TaskRunner
  class TaskNotFoundError < StandardError; end

  class TaskManager 

    attr_reader :tasks

    def initialize 
      @tasks = []
    end

    def add(task, deps=[])
      tasks << {'task' => task, 'deps' => deps}
    end

    def find(name) 
      task_record = find_task_record_by_name(name)
      task_record['task']
    end

    def deps(name)
      task_record = find_task_record_by_name(name)
      task_record['deps'].map {|task_name| find(task_name)}
    end


    private 

    def find_task_record_by_name(name)
      task_record = tasks.find {|tr| tr['task'].name == name}
      raise TaskRunner::TaskNotFoundError.new("Task with name '#{name}' does not exist") if task_record.nil? 
      task_record
    end

  end

end
