class GraphqlController < ApplicationController
  def execute
    result = NotaSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: {current_user: current_user},
      operation_name: params[:operationName]
    )
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def current_user
    TokenAuthentication.new(
      token_string: request.headers["HTTP_AUTHORIZATION"]
    ).authenticate
  end

  def headers
    request.headers
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {error: {message: e.message, backtrace: e.backtrace}, data: {}}, status: 500
  end
end
