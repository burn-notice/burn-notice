class AddQuestionToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :question, :string
  end
end
