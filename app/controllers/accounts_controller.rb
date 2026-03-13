class AccountsController < ApplicationController
  def create
    @account = Account.new(params.permit!)

    if @account.save
      render json: @account.to_json.merge(password: @account.password), status: 201
    else
      render json: { error: @account.errors.full_messages }, status: 422
    end
  end

  def login
    @account = Account.authenticate(params[:email], params[:password])

    if @account
      session[:account_id] = @account.id
      render json: { message: "Logged in", api_key: @account.api_key }
    else
      if Account.find_by(email: params[:email])
        render json: { error: "Invalid password" }, status: 401
      else
        render json: { error: "Email not found" }, status: 401
      end
    end
  end

  def show
    @account = Account.find(params[:id])
    render json: @account.to_json
  end

  def make_admin
    @account = Account.find(params[:id])
    @account.update!(admin: true)
    render json: { message: "Account is now admin" }
  end
end
