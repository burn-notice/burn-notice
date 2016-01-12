require "administrate/base_dashboard"

class OpeningDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    notice: Field::BelongsTo,
    id: Field::Number,
    ip: Field::String,
    info: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    meta: Field::String.with_options(searchable: false),
    authorization: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :notice,
    :id,
    :ip,
    :info,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :notice,
    :ip,
    :info,
    :meta,
    :authorization,
  ]

  # Overwrite this method to customize how openings are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(opening)
  #   "Opening ##{opening.id}"
  # end
end
