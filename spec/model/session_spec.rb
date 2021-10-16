require 'rails_helper'

RSpec.describe 'Session', type: :model do

  describe 'test' do
    let!(:user) { create(:user) }
    let!(:session) { create(:session, user_id: user.id, token_digest: "aaaaa", expires_at: DateTime.current.since(10.days)) }

    context 'test' do
      it 'true' do
        expect(session.user_id).to eq user.id
      end
    end

    context 'login streak' do
      it 'streak valid' do
        session.save
        expect(session.login_streak).to eq 1
      end

      it 'streak increase' do
        session.created_at = Time.parse('2021-10-15')
        session.updated_at = Time.parse('2021-10-16')
        session.save
        expect(session.login_streak).to eq 2
      end
    end

  end

end