class GroupIdentifierLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :identifier
end

# == Schema Information
#
# Table name: group_identifier_links
#
#  id            :integer          not null, primary key
#  group_id      :integer          not null
#  identifier_id :integer          not null
#
# Indexes
#
#  index_group_identifier_links_on_group_id_and_identifier_id  (group_id,identifier_id) UNIQUE
#  index_group_identifier_links_on_identifier_id               (identifier_id)
#
