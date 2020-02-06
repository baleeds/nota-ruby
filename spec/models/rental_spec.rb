require "rails_helper"

describe Rental, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build_stubbed(:rental)).to be_valid
    end
  end

  describe ".latest" do
    it "scopes to the earliest created rentals" do
      fourth_rental = create(:rental, created_at: 4.years.ago)
      first_rental = create(:rental, created_at: 1.years.ago)
      second_rental = create(:rental, created_at: 2.years.ago)
      third_rental = create(:rental, created_at: 3.years.ago)

      result = described_class.latest

      expect(result).to eq([first_rental, second_rental, third_rental, fourth_rental])
    end

    describe ".active" do
      it "returns active rentals" do
        rental = create(:rental)
        rental2 = create(:rental)

        result = described_class.active

        expect(result).to contain_exactly(rental, rental2)
      end

      it "excudes returned rentals" do
        book = create(:book)
        rental = create(:rental, book: book)
        create(:rental, returned_at: DateTime.now)

        result = described_class.active

        expect(result).to contain_exactly(rental)
      end
    end

    describe ".for_user" do
      it "returns all rentals related to that user" do
        user = create(:user)
        user_rental_one = create(:rental, user: user)
        user_rental_two = create(:rental, user: user)
        other_rental_one = create(:rental)
        other_rental_two = create(:rental)

        result = described_class.for_user(user).latest

        expect(result).to_not include(other_rental_one, other_rental_two)
        expect(result).to eq([user_rental_two, user_rental_one])
      end

      it "returns all the rentals ordered from newest to oldest" do
        user = create(:user)
        oldest = create(:rental, user: user, created_at: 3.months.ago)
        middle = create(:rental, user: user, created_at: 2.months.ago)
        newest = create(:rental, user: user, created_at: 1.month.ago)

        rentals = Rental.for_user(user).latest

        expect(rentals).to eq([newest, middle, oldest])
      end
    end
  end
end
