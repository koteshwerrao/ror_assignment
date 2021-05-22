class QuestionsController < ApplicationController
	require 'csv'
  def index
  	@questions ||= Question.all
  end

  def upload
  	uploaded_file = params[:file]
  	count = 0
  	CSV.foreach(uploaded_file.path) do |row_data|
  	 if count > 0
  	  store_data(row_data)
  	 end
  	 count+= 1
  	end
  	redirect_to '/'
  end

  # Private methods
  private
  def store_data(row_data)
  	question_data = 0
  	role_data = 0
  	mapping_data = 0
  	unless row_data.empty?
	  	create_role( row_data [6] )
	  	create_mapping( row_data[9] )
	  	question_data = row_data.select.with_index { |val, index| [6,9].include?(index) == false }
	  	create_question( question_data, row_data [6], row_data[9])
  	end
  end

  def create_question(questions, role, mapping)
  	role_id = Role.find_by(role_type: role).id
  	mapping_id = Mapping.find_by(map_name: mapping).id
  	questions_title = Question.pluck(:qu_title)
  	unless questions_title.include?(questions[1])
	  	question = Question.new
	  	question.pri = questions[0]
	  	question.qu_title = questions[1]
	  	question.team_stages = questions[2]
	  	question.appears = questions[3]
	  	question.frequency = questions[4]
	  	question.qus_type = questions[5]
	  	question.required = questions[6]
	    question.conditions = questions[7]
	  	question.role_id = role_id
	  	question.mapping_id = mapping_id
	  	question.save!
  	end
  end

  def create_role(title)
  	roles_type = Role.pluck(:role_type)
  	unless roles_type.include?(title)
  		role = Role.new
  		role.role_type = title
  		role.save!
  	end
  end

  def create_mapping(title)
  	mapping_titles = Mapping.pluck(:map_name)
		unless mapping_titles.include?(title)
		  mapping = Mapping.new
		  mapping.map_name = title
		  mapping.save!
		end
  end
end
