require "spec_helper"

describe CommaSeparatedStorage do
  class SingularizingString < String
    def singularize; self; end
    def to_s;        self; end
  end

  class Widget
    extend CommaSeparatedStorage
    attr_accessor :languages, :doors, :sheep
    comma_separated_storage :languages, :interrogate => :speaks?
    comma_separated_storage :doors
    comma_separated_storage SingularizingString.new("sheep")
  end

  describe "languages" do
    let(:widget) { Widget.new }

    it "should return the list of languages available for the widget" do
      widget.languages = "fr,en,de"
      widget.language_list.should == %w{ fr en de }
      widget.default_language.should == :fr
      widget.speaks?("fr").should == "fr"
      widget.speaks?("en").should == "en"
      widget.speaks?("de").should == "de"
      widget.speaks?("ru").should == false
      widget.speaks?("it").should == false
      widget.speaks?("jp").should == false
    end

    it "should return default language as a sym" do
      widget.languages = "it,fr,en,de"
      widget.default_language.should == :it
      widget.speaks?("ru").should == false
      widget.speaks?("it").should == "it"
    end

    it "should return default language if it is the only one" do
      widget.languages = "it"
      widget.single_language.should == "it"
    end

    it "should return nil if it has several languages" do
      widget.languages = "it,fr,en,ie"
      widget.single_language.should == nil
    end
  end

  describe "language_list" do
    let(:widget) { Widget.new }

    it "should set the #languages attribute" do
      widget.language_list = %w{ en fr ru jp }
      widget.languages.should == "en,fr,ru,jp"
    end

    it "should read the #languages attribute" do
      widget.languages = "en,fr,ru,jp"
      widget.language_list.should == %w{ en fr ru jp }
    end

    it "doesn't die when #languages is nil" do
      widget.language_list.should == []
    end

    it "doesn't die when #languages is empty" do
      widget.languages = ""
      widget.language_list.should == []
    end

    it "should convert a non-array argument to an array of length 1" do
      widget.language_list = "ru"
      widget.languages.should == "ru"
      widget.language_list.should == ["ru"]
    end
  end

  describe "each_lang" do
    let(:widget) { Widget.new }

    it "should set the #languages attribute" do
      widget.language_list = %w{ en fr ru jp }
      list = []
      widget.each_language { |x|
        list << x
      }
      list.should == %w{ en fr ru jp }
    end
  end

  describe "doors" do
    let(:widget) { Widget.new }
    it "should generate :has_door?" do
      widget.doors = "tall,short,medium"
      widget.has_door?("tall").should == "tall"
      widget.has_door?("small").should == false
    end

    it "should generate :multi_door" do
      widget.doors = "tall,short,medium"
      widget.multi_door == true
      widget.single_door == nil
    end

    it "should generate :multi_door" do
      widget.doors = "short"
      widget.multi_door == false
      widget.single_door == "short"
    end
  end

  describe "with :singularize" do
    let(:widget) { Widget.new }
    it "should generate :has_sheep?" do
      widget.sheep = "Tim,Tom,Ben,Jim"
      widget.sheep_list.should == %w{ Tim Tom Ben Jim }
      widget.has_sheep?("Tim").should == "Tim"
      widget.has_sheep?("Ken").should == false
    end

    it "should generate :multi_sheep" do
      widget.sheep = "Tim,Tom,Ben"
      widget.multi_sheep == true
      widget.single_sheep == nil
    end

    it "should generate :multi_sheep" do
      widget.sheep = "Jim"
      widget.multi_sheep == false
      widget.single_sheep == "Jim"
    end
  end
end
