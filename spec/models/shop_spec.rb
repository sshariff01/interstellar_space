require_relative '../../app/models/shop'

describe Shop do
  describe 'on save' do
    describe ':name' do
      it 'creates an error if the name length is not between 3 and 40 characters' do
        name_too_short = Shop.create(:name => 'Hi')
        name_too_long = Shop.create(:name => 'This is my Shop Name, and it is way too long')
        name_valid = Shop.create(:name => 'Valid Shop Name')

        expect(error_message_for(name_too_short, :name)).to include('is too short (minimum is 3 characters)')
        expect(error_message_for(name_too_long, :name)).to include('is too long (maximum is 40 characters)')
        expect(error_message_for(name_valid, :name)).to be_empty
      end

      it 'creates an error if name begins or ends in whitespace' do
        name_whitespace_start = Shop.create(:name => '  Hello')
        name_whitespace_end = Shop.create(:name => 'Hello ')
        name_whitespace_only = Shop.create(:name => '     ')
        name_valid = Shop.create(:name => 'Hello World')

        expect(error_message_for(name_whitespace_start, :name)).to include('Name must not begin or end with whitespace')
        expect(error_message_for(name_whitespace_end, :name)).to include('Name must not begin or end with whitespace')
        expect(error_message_for(name_whitespace_only, :name)).to include('Name must not begin or end with whitespace')
        expect(error_message_for(name_valid, :name)).to be_empty
      end
    end

    describe ':subdomain' do
      it 'creates an error if the subdomain length is not between 3 and 25 characters' do
        subdomain_too_short = Shop.create(:subdomain => 'hi')
        subdomain_too_long = Shop.create(:subdomain => 'this-is-my-subdomain-name-which-is-way-too-long')
        subdomain_valid = Shop.create(:subdomain => 'helloworld')

        expect(error_message_for(subdomain_too_short, :subdomain)).to include('is too short (minimum is 3 characters)')
        expect(error_message_for(subdomain_too_long, :subdomain)).to include('is too long (maximum is 25 characters)')
        expect(error_message_for(subdomain_valid, :subdomain)).to be_empty
      end

      it 'creates an error if subdomain contains characters other than A-z, 0-9, and -' do
        subdomain_with_underscore = Shop.create(:subdomain => 'inval1d_subd0ma19')
        subdomain_with_space = Shop.create(:subdomain => 'inval1d subd0ma19')
        subdomain_with_punctuation = Shop.create(:subdomain => 'inval1d,subd0ma19')
        subdomain_valid = Shop.create(:subdomain => 'val1d-subd0ma19')

        expect(error_message_for(subdomain_with_underscore, :subdomain)).to include('Subdomain may only contain alphanumeric characters')
        expect(error_message_for(subdomain_with_space, :subdomain)).to include('Subdomain may only contain alphanumeric characters')
        expect(error_message_for(subdomain_with_punctuation, :subdomain)).to include('Subdomain may only contain alphanumeric characters')
        expect(error_message_for(subdomain_valid, :subdomain)).to be_empty
      end

      it 'creates an error if subdomain specified already exists' do
        subdomain = Shop.create(:name => 'Diamond Store', :subdomain => 'hello-world')
        subdomain_duplicate = Shop.create(:name => 'Thrift Shop', :subdomain => 'hello-world')

        expect(error_message_for(subdomain, :subdomain)).to be_empty
        expect(error_message_for(subdomain_duplicate, :subdomain)).to include('has already been taken')
      end
    end
  end

  describe '#urn' do
    context 'when supplied with a domain name' do
      it 'returns the URN for the shop' do
        shop = Shop.create(:name => 'Apple Store', :subdomain => 'apple-store')

        urn = shop.urn('domain')

        expect(urn).to eq('apple-store.domain')
      end
    end
  end

  def error_message_for(model, attribute)
    model.errors.try(:messages)[attribute]
  end
end
