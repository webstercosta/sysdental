require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do

  <% attributes_names.each do |attribute_name| %>it{ is_expected.to validate_presence_of :<%= attribute_name %> }
  <% end %>

end
<% end -%>
