# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Graphql API', :graphql, type: :request do
  describe 'POST #execute' do
    context 'with no query' do
      it 'successfully executes' do
        post graphql_url, params: { query: '' }

        expect(response).to have_http_status(:ok)
        expect(json_response).to be_empty
      end

      context 'with a query' do
        let(:query) do
          <<-'GRAPHQL'
            query {
              me {
                id
              }
            }
          GRAPHQL
        end

        it 'successfully executes with an authenticated user' do
          user = create(:user)

          post graphql_url,
               params: {
                 query: query
               },
               headers: {
                 authorization: token_string(user)
               }

          expect(response).to have_http_status(:ok)
          expect(json_response).to eq(
            data: {
              me: {
                id: global_id(user, Outputs::UserType)
              }
            }
          )
        end

        it 'returns an UNAUTHENTICATED code with an invalid user' do
          post graphql_url,
               params: {
                 query: query
               },
               headers: {
                 authorization: 'invalid-token'
               }

          expect(response).to have_http_status(:ok)
          expect(json_response).to include(
            errors: [
              a_hash_including(
                extensions: {
                  code: 'UNAUTHENTICATED'
                }
              )
            ]
          )
        end
      end
    end
  end

  def json_response
    ActiveSupport::JSON.decode(@response.body).deep_symbolize_keys
  end

  def token_string(user)
    JWT.encode(
      { email: user.email },
      AccessToken::SECRET, AccessToken::ALGORITHM
    )
  end
end
