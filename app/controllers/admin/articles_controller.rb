module Admin
  class ArticlesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Article.all.paginate(10, params[:page])
    # end

    def find_resource(param)
      Article.from_param(param)
    end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
