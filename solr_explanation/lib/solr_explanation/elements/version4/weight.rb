#
#   Copyright [2011-2012] [Solr.pl, Marek Rogoziński, Rafał Kuć]
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
require 'solr_explanation/explanation'
require 'solr_explanation/elements/version3_4/weight'
require 'solr_explanation/elements/version3_4/query_weight'
require 'solr_explanation/elements/version4/field_weight'

module SolrExplanation
  module Element
    module Version4
      class Weight < Element::Version3_4::Weight

        def available_children
          [
#            Element::Version3_4::QueryWeight,
            Element::Version4::FieldWeight
          ]
        end

        def self.matches?(line)
          line =~ Explanation.regexp(/\((NON-)?MATCH\) weight\(.* in \d+\) \[\S+\], result of:/)
        end

        def parse_details_post
          if @value =~ /weight\((.*) in \d+\) \[(\S+)\]/
            add_attribute(:query, $1)
            add_attribute(:similarity, $2)
          end
        end
      end
    end
  end
end
