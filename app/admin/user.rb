ActiveAdmin.register User do
  index do
    selectable_column

    column :id
    column :nickname
    column :email
    column(:authorizations) { |it| it.authorizations.map(&:provider).to_sentence }
  end
end
