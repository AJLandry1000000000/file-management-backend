class PeopleController < ApplicationController
    include Pagy::Backend
  
    def index
      keyword = params[:keyword]
      location = params[:location]
      affiliation = params[:affiliation]
  
      people = Person.all
  
      if location.present?
        people = people.joins(:locations)
                       .where('locations.name = ?', location)
      end
  
      if affiliation.present?
        people = people.joins(:affiliations)
                       .where('affiliations.name = ?', affiliation)
      end
  
      if keyword.present?
        people = people.where('first_name ILIKE ? OR last_name ILIKE ?', "%#{keyword}%", "%#{keyword}%")
      end
  
    #   @pagy, @people = pagy(people) # Pagination is now done on the frontend.
      render json: { people: people }
    end
  end