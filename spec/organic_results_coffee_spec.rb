describe "SerpApi Mobile JSON" do

  describe "Organic Results for Coffee" do

    before(:all) do
      @response = HTTP.get 'https://serpapi.com/search.json?q=Coffee&location=Dallas&hl=en&gl=us&source=test&device=mobile'
      @json = @response.parse
    end

    it "returns http success" do
      expect(@response.code).to be(200)
    end

    it "contains organic results array" do
      expect(@json["organic_results"]).to be_an(Array)
    end

    describe "have first Wikipedia result" do

      before :all do
        @result = @json["organic_results"][0]
      end

      it "is first" do
        expect(@result["position"]).to be(1)
      end

      it "titles wikipedia" do
        expect(@result["title"]).to eql("Coffee - Wikipedia")
      end

      it "links wikipedia" do
        expect(@result["link"]).to eql("https://en.m.wikipedia.org/wiki/Coffee")
        expect(@result["displayed_link"]).to eql("Wikipedia › wiki › Coffee")
      end

      it "has a snippet" do 
        expect(@result["snippet"]).to_not be_empty
      end

    end

    describe 'have related searches section' do

      before(:all) do
        @related_searches = @json["related_searches"]
      end

      it 'more than 5 related_searches' do
        expect(@related_searches.size).to be > 5
      end

      it "first has query field" do
        expect(@related_searches[0]["query"]).not_to be_empty
      end

      it "first has link field" do
        expect(@related_searches[0]["link"]).to match(/search\?/)
      end

      it "check all related_search have query and link" do
        @related_searches.each_with_index do |s, index|
          expect(s['query']).not_to be_empty, "empty query at index: #{index}"
          expect(s['link']).not_to be_empty, "empty link at index: #{index}"
        end
      end
    end
  end

end