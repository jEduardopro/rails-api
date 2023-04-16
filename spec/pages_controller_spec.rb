
describe PagesController, type: :controller do

	describe "GET index" do
		
		subject { get :index, params: params}

		let(:sort_by) { 'created_at' }
		let(:sort_direction) { 'desc' }
		let(:page) { 1 }
		let(:page_size) { 15 }

		let(:params) do 
			{
				sort_by: sort_by,
				sort_direction: sort_direction,
				page: page,
				page_size: page_size
			}
		end

		context "when there are pages" do 
			let(:user) { create(:user) }
			let(:payload) { {'data' => {'id' => user.id} } }
			let(:token) { SecureRandom.hex(32) }
			before do 
				controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
				expect(JWT).to receive(:decode).and_return([payload])
			end

			let!(:pages) { create_list(:page, 5) }

			it "get all pages" do
				subject
				expect(subject).to have_http_status(:ok)
				expect(subject.body).to include_json(
					data: [],
					page: 1
				)				
				expect(JSON.parse(subject.body)['data'].size).to eq(5)
				expect(JSON.parse(subject.body)['data'].size).to eq(5)
			end
		end
	end
end
