class JokesController < ApplicationController
  def index
    render json: Joke.all
  end

  def create
    @joke = Joke.new(joke_params)
    render json: @joke && return if @joke.save

    render json: { error: "Unable to save joke: #{@joke.errors.messages}" }, status: 400
  end

  private

  # Specify which params are required, this method can be called in any action
  # but we only use it now for the create method.
  # we require the body to have the following form:
  # {
  #     "joke": {
  #       "category": "foo",
  #       "content": "foobarbaz123"
  #     }
  # }
  #
  # Note that permit, as the name indicates, allows this parameters to be passed
  # but it doesn't make them mandatory.
  # By doing this we are using what's known as string parameters.
  def joke_params
    params.require(:joke).permit(:category, :content)
  end
end
