require 'rails_helper'

describe FriendshipService, type: :service do
  describe '#friends_up_to_second_degree' do
    let(:user) { create(:user) }

    subject { described_class.new(user).friends_up_to_second_degree }

    context 'when user has no friends' do
      it 'returns user id' do
        expect(subject).to contain_exactly(user.id)
      end
    end

    context 'when user has friends' do
      let!(:friendship1) { create(:friendship, user_a: user) }
      let!(:friendship2) { create(:friendship, user_a: user) }
      let!(:friendship_second_degree1) do
        create(:friendship, user_a: friendship1.user_b)
      end
      let!(:friendship_second_degree2) do
        create(:friendship, user_a: friendship1.user_b)
      end
      let!(:friendship_third_degree) do
        create(:friendship, user_a: friendship_second_degree1.user_b)
      end
      let!(:user_not_freind) { create(:user) }

      it 'returns friends up to second degree' do
        expected_users = [user, friendship1.user_b, friendship2.user_b,
                          friendship_second_degree1.user_b, friendship_second_degree2.user_b]
        expect(subject).to match_array(expected_users.pluck(:id))
      end
    end
  end
end
