# frozen_string_literal: true

module MockOrdway
  class Repositories
    def self.add_repositories(*args)
      args.each do |arg|
        define_method(arg) do
          instance_variable_get("@#{arg}") || instance_variable_set("@#{arg}", RepoHash.new)
        end
      end
    end

    add_repositories :customers

    class RepoHash < Hash
      def fetch(*)
        super
      rescue KeyError => e
        raise StandardError.new(message: "#{e.key} not found")
      end
    end
  end
end
