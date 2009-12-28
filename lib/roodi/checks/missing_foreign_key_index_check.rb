require 'roodi/checks/check'
require 'pathname'

module Roodi
  module Checks
    # Checks to make sure for loops are not being used..
    #
    # Using a for loop is not idiomatic use of Ruby, and is usually a sign that someone with
    # more experience in a different programming language is trying out Ruby.  Use
    # Enumerable.each with a block instead.
    class MissingForeignKeyIndexCheck < Check
      def initialize
        @foreign_keys = {}
        @indexes = {}
      end

      def interesting_nodes
        [:call]
      end

      def evaluate_start_call(node)
        if analyzing_schema(node)
          if creating_table(node)
            @current_table = create_table_name(node)
          end

          if creating_foreign_key(node)
            @foreign_keys[@current_table] ||= []
            @foreign_keys[@current_table] << foreign_key_column_name(node)
          end

          if adding_index(node)
            @indexes[index_table_name(node)] ||= []
            @indexes[index_table_name(node)] << index_column_name(node)
          end
        end
      end
      
      def evaluate_end_call(node)
        #ignored
      end

      def analyzing_schema(node)
        pathname = Pathname.new(node.file)
        @analyzing_schema ||= ("schema.rb" == pathname.basename.to_s)
      end

      def creating_table(node)
        :create_table == node[2]
      end

      def create_table_name(node)
        # Get table name out of this:
        # s(:call, nil, :create_table, s(:arglist, s(:str, "duplicate_blocks"), s(:hash, s(:lit, :force), s(:true))))
        node[3][1][1]
      end

      def creating_foreign_key(node)
        #s(:call, s(:lvar, :t), :integer, s(:arglist, s(:str, "duplicate_set_id"), s(:hash, s(:lit, :null), s(:false))))
        column_type = node[2]
        column_name = node[3][1][1]
        :integer == column_type && "_id" == column_name[-3,3]
      end

      def foreign_key_column_name(node)
        #s(:call, s(:lvar, :t), :integer, s(:arglist, s(:str, "duplicate_set_id"), s(:hash, s(:lit, :null), s(:false))))
        column_name = node[3][1][1]
      end

      def adding_index(node)
        :add_index == node[2]
      end

      def index_table_name(node)
        # Get table name out of this:
        # s(:call, nil, :add_index, s(:arglist, s(:str, "duplicate_blocks"), s(:array, s(:str, "duplicate_set_id")), s(:hash, s(:lit, :name), s(:str, "index_duplicate_blocks_on_duplicate_set_id"))))
        node[3][1][1]
      end

      def index_column_name(node)
        # Get index column name out of this:
        # s(:call, nil, :add_index, s(:arglist, s(:str, "duplicate_blocks"), s(:array, s(:str, "duplicate_set_id")), s(:hash, s(:lit, :name), s(:str, "index_duplicate_blocks_on_duplicate_set_id"))))
        node[3][2][1][1]
      end

      def end_file(filename)
        @foreign_keys.keys.each do |table|
          foreign_keys = @foreign_keys[table] || []
          indexes = @indexes[table] || []
          missing_indexes = foreign_keys - indexes
          missing_indexes.each do |fkey| 
            add_error("Table '#{table}' is missing an index on the foreign key '#{fkey}'", filename, 1)
          end
        end
      end
    end
  end
end
