require 'rails_helper'

describe PaymentService, type: :service do
  describe '#create!' do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:sender_initial_balance) { 50 }
    let(:receiver_initial_balance) { 50 }
    let(:description) { 'description' }
    let(:amount) { 10 }

    before do
      sender.payment_account.update!(balance: sender_initial_balance)
      receiver.payment_account.update!(balance: receiver_initial_balance)
    end

    subject { described_class.new(sender, receiver, amount, description).create! }

    context 'when sender and receiver are not friends' do
      it 'raises a NotFriend error' do
        expect { subject }.to raise_exception(Exceptions::NotFriend).and(
          change(Payment, :count).by(0)
        )
      end
    end

    context 'when sender and receiver are friends' do
      let!(:friendship) { create(:friendship, user_a: sender, user_b: receiver) }

      it 'does not raise a argument error' do
        expect { subject }.not_to raise_exception(Exceptions::NotFriend)
      end

      it 'decreases sender balance' do
        expect { subject }.to change(sender, :payment_account_balance).from(50).to(40)
      end

      it 'increases recevier balance' do
        expect { subject }.to change(receiver, :payment_account_balance).from(50).to(60)
      end

      it 'creates Payment' do
        expect { subject }.to change(Payment, :count).by(1)
      end

      it 'creates Payment with correct attributes' do
        subject
        expect(Payment.last.sender).to eq(sender)
        expect(Payment.last.receiver).to eq(receiver)
        expect(Payment.last.amount).to eq(amount)
        expect(Payment.last.description).to eq(description)
      end

      context 'when amount is negative' do
        let(:amount) { -10 }

        it 'raises a RecordInvalid error' do
          expect { subject }.to raise_exception(ActiveRecord::RecordInvalid).and(
            change(Payment, :count).by(0)
          )
        end
      end
    end
  end
end
