ActiveAdmin.register Notice do
  # index do
  #   selectable_column

  #   column :id
  #   column :date
  #   column(:profile_names) { |it| it.profiles.map(&:name).to_sentence }
  #   column :location
  #   column :email_sent_at

  #   actions
  # end

  # permit_params :date, :email_sent_at, :location

  form do |f|
    f.semantic_errors
    f.inputs 'Details' do
      f.input :shared_secret
    end
    f.actions
  end
end
