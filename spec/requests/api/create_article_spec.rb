RSpec.describe 'POST /api/articles', type: :request do
  subject { response }
  let(:category) { create(:category) }
  describe 'successful, when the article is created' do
    before do
      post '/api/articles',
           params: { article: { title: 'Amazing title',
                                lede: 'Amazing lede...',
                                body: 'Amazing body',
                                category_id: category.id,
                                category_name: category.name } }
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to return a response message' do
      expect(response_json['message']).to eq(
        'You have successfully added Amazing title to the site'
      )
    end
  end

  describe 'unsuccessful, when the article is not created' do
    describe 'because the title is missing' do
      before do
        post '/api/articles',
             params: { article: { lede: "I'm missing a title",
                                  body: "I'm missing a title",
                                  category_id: category.id,
                                  category_name: category.name } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to to ask for a title when the title is missing' do
        expect(response_json['errors']).to eq(
          "Title can't be blank"
        )
      end
    end

    describe 'because the lede is missing' do
      before do
        post '/api/articles',
             params: { article: { title: 'I forgot the lede',
                                  body: 'I forgot the lede',
                                  category_id: category.id,
                                  category_name: category.name } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to ask for a lede when the lede is missing' do
        expect(response_json['errors']).to eq(
          "Lede can't be blank"
        )
      end
    end

    describe 'because the body is missing' do
      before do
        post '/api/articles',
             params: { article: { title: 'I forgot the body',
                                  lede: 'I forgot the body',
                                  category_id: category.id,
                                  category_name: category.name } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to ask for the body when the body is missing' do
        expect(response_json['errors']).to eq("Body can't be blank")
      end
    end

    describe 'because the category is missing' do
      before do
        post '/api/articles',
             params: { article: { title: 'I forgot the category',
                                  lede: 'I forgot the category',
                                  body: 'I forgot the category',
                                  category_name: category.name } }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to as for the category when the category is missing' do
        expect(response_json['errors']).to eq("Category can't be blank and Category must exist")
      end
    end
  end
end
