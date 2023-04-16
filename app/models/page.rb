class Page < ApplicationRecord
	include HasUuid
	PREFIX = 'pag'
  belongs_to :funnel, optional: true
end
