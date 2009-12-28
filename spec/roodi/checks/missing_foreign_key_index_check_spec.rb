require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Roodi::Checks::MissingForeignKeyIndexCheck do
  before(:each) do
    @roodi = Roodi::Core::Runner.new(Roodi::Checks::MissingForeignKeyIndexCheck.new)
  end

  it "should warn about a missing foreign key" do
    content = <<-END
ActiveRecord::Schema.define(:version => 20091215233604) do
  create_table "projects", :force => true do |t|
    t.string   "name"
  end

  create_table "revisions", :force => true do |t|
    t.integer  "project_id"
    t.string   "key"
  end

  add_index "revisions", ["project_id"], :name => "index_revisions_on_project_id"

  create_table "source_files", :force => true do |t|
    t.integer "revision_id"
    t.string  "filename"
  end
end
    END
    @roodi.check_content(content, "schema.rb")
    errors = @roodi.errors
    errors.should_not be_empty
    errors[0].to_s.should eql("schema.rb:1 - Table 'source_files' is missing an index on the foreign key 'revision_id'")
  end
end
