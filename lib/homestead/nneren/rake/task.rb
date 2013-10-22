module Homestead
  module Nneren
    module Rake
      class RetsUpdateTask
        include ::Rake::DSL if defined?(::Rake::DSL)

        def initialize(task_name = 'rets_update', desc = 'Update RETS properties')
          @task_name, @decs = task_name, desc
          define_task
        end

        def define_task
          desc @desc
          task @task_name do
            updater.update
          end
        end

        def updater
          return Homestead::Nneren::RetsImporter.new
        end
      end
    end
  end
end
