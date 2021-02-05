require 'pagy/extras/overflow'

Pagy::VARS[:items] = ENV.fetch('ITEMS_PER_PAGE')
Pagy::VARS[:overflow] = :last_page
