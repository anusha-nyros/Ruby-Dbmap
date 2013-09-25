class SchemasController < ApplicationController
	def index
		@h_type = Database.get_schema() 
        @error = @h_type if @h_type.class == String
	end
end
