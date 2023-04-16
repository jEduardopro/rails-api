class Page < ApplicationRecord
	include HasUuid
	PREFIX = 'pag'
	MODULES_TYPES = {
		'funnels' => 'funnels',
		'shop' => 'shop',
		'blog' => 'blog',
		'membersite' => 'membersite',
	}.freeze

	enum module: MODULES_TYPES

  belongs_to :funnel, optional: true
end
