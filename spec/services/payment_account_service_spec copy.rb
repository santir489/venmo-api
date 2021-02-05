require 'rails_helper'

describe PaymentAccountService, type: :service do
  describe '#increase!' do
    let(:user) { create(:user) }
    before do
      user.payment_account.update!(balance: 10)
    end

    subject { described_class.new(user.payment_account).increase!(amount) }

    context 'when amount is positive' do
      let(:amount) { 20 }

      it 'increases account balance 10 dolars' do
        expect { subject }.to change(user.payment_account, :balance).from(10).to(30)
      end
    end

    context 'when amount is negative' do
      let(:amount) { -20 }

      it 'does not change balance' do
        expect { subject }.not_to change(user.payment_account, :balance)
      end
    end
  end

  describe '#decrease!' do
    let(:user) { create(:user) }

    before do
      user.payment_account.update!(balance: initial_balance)
    end

    subject { described_class.new(user.payment_account).decrease!(amount) }

    context 'when amount is positive' do
      let(:amount) { 10 }

      context 'when amount is smaller than balance' do
        let(:initial_balance) { 20 }

        it 'decreases account balance 10 dolars' do
          expect { subject }.to change(user.payment_account, :balance).from(20).to(10)
        end

        it 'does not call MoneyTransferService' do
          expect_any_instance_of(MoneyTransferService).not_to receive(:transfer)
          subject
        end
      end

      context 'when amount is greater than balance' do
        let(:initial_balance) { 6 }

        it 'decreases account balance to 0 dolars' do
          expect { subject }.to change(user.payment_account, :balance).from(6).to(0)
        end

        it 'calls MoneyTransferService' do
          expect_any_instance_of(MoneyTransferService).to receive(:transfer).with(4)
          subject
        end
      end
    end

    context 'when amount is negative' do
      let(:amount) { -20 }
      let(:initial_balance) { 40 }

      it 'does not change balance' do
        expect { subject }.not_to change(user.payment_account, :balance)
      end
    end
  end
end
