module TaskRunner
  class Task
    attr_reader :name, :description, :deps

    def initialize(name, action, description, deps=[])
      raise ArgumentError.new('Action must be callable') unless action.respond_to? :call
      @name = name
      @description = description
      @action =  action
      @deps = deps
    end

    def invoke
      @action.call
    end
  end
end
