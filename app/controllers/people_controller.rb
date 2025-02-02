class PeopleController < ApplicationController
    include Pagy::Backend

    def index
        @pagy, @people = pagy(Person.all, items: 3)
        render json: { people: @people, pagy: @pagy }
    end
end