# frozen_string_literal: true

require "lingua/stemmer"

module Jobready
  module Coding
    module Test
      class Classifier
        STEMMER = Lingua::Stemmer.new(language: "en")

        FOOD_STEMS = %w{chocolate}.map { |word| STEMMER.stem(word) }
        MEDICINE_STEMS = %w{pill}.map { |word| STEMMER.stem(word) }
        BOOK_STEMS = %w{book}.map { |word| STEMMER.stem(word) }

        SALES_TAX_EXEMPT_STEMS = FOOD_STEMS + MEDICINE_STEMS + BOOK_STEMS

        IMPORTED_STEMS = %w{imported}.map { |word| STEMMER.stem(word) }

        def self.is_sales_tax_exempt?(description)
          stems = self.stems(description)
          stems.any? { |stem| SALES_TAX_EXEMPT_STEMS.include? stem }
        end

        def self.is_imported?(description)
          stems = self.stems(description)
          stems.any? { |stem| IMPORTED_STEMS.include? stem }
        end

        private

        def self.stems(description)
          # This will need to be more complex in future.
          words = description.split

          stems = words.map { |word| STEMMER.stem(word) }

          stems.sort.uniq
        end
      end
    end
  end
end
