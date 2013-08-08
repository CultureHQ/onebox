module Onebox
  class Preview
    class Wikipedia
      TEMPLATE = File.read(File.join("templates", "wikipedia.handlebars"))

      def initialize(document, link)
        @url = link
        @body = document
        @data = extracted_data
        @view = Mustache.render(TEMPLATE, @data)
      end

      def to_html
        @view
      end

      private

      def extracted_data
        {
          url: @url,
          name: @body.css("html body h1").inner_text,
          image: @body.css("html body img")[1]["src"],
          description: @body.css("html body p").inner_text
        }
      end
    end
  end
end
