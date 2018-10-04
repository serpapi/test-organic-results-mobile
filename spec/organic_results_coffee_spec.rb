describe "SerpApi Mobile JSON" do

  describe "Organic Results for Coffee" do

    before :all do
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

  end

end